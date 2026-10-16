import { useEffect, useState, useCallback } from 'react';
import api from '../api/client';
import { useAuth } from '../context/AuthContext';

const STATUSES = [
  { value: 'pending',     label: 'Pending',     color: '#f59e0b' },
  { value: 'in_progress', label: 'In Progress', color: '#3b82f6' },
  { value: 'completed',   label: 'Completed',   color: '#10b981' },
];

const emptyForm = { title: '', description: '', status: 'pending', user_id: '' };

export default function Tasks() {
  const { user, logout } = useAuth();
  const isAdmin = user?.role === 'admin';

  const [tasks, setTasks]           = useState([]);
  const [users, setUsers]           = useState([]);
  const [meta, setMeta]             = useState(null);
  const [loading, setLoading]       = useState(false);
  const [form, setForm]             = useState(emptyForm);
  const [editingId, setEditingId]   = useState(null);
  const [error, setError]           = useState('');

  // Filter / pagination state
  const [search, setSearch]         = useState('');
  const [status, setStatus]         = useState('');
  const [page, setPage]             = useState(1);
  const perPage                     = 5;

  const loadTasks = useCallback(async () => {
    setLoading(true);
    try {
      const { data } = await api.get('/tasks', {
        params: {
          search:   search || undefined,
          status:   status || undefined,
          page,
          per_page: perPage,
        },
      });
      setTasks(data.data);
      setMeta(data.meta);
    } catch (err) {
      setError('Failed to load tasks');
    } finally {
      setLoading(false);
    }
  }, [search, status, page]);

  const loadUsers = async () => {
    if (!isAdmin) return;
    const { data } = await api.get('/admin/users');
    setUsers(data.filter((u) => u.role === 'user'));
  };

  useEffect(() => { loadTasks(); }, [loadTasks]);
  useEffect(() => { loadUsers(); }, [isAdmin]);

  // Debounce search input — wait 400ms after typing stops
  useEffect(() => {
    const timer = setTimeout(() => setPage(1), 400);
    return () => clearTimeout(timer);
  }, [search, status]);

  const resetForm = () => {
    setForm(emptyForm);
    setEditingId(null);
    setError('');
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');

    if (!form.title.trim()) return setError('Title is required.');
    if (isAdmin && !editingId && !form.user_id) {
      return setError('Please select a user to assign this task to.');
    }

    try {
      if (editingId) {
        await api.put(`/tasks/${editingId}`, {
          title: form.title,
          description: form.description,
          status: form.status,
        });
      } else {
        await api.post('/tasks', {
          title: form.title,
          description: form.description,
          status: form.status,
          ...(isAdmin ? { user_id: Number(form.user_id) } : {}),
        });
      }
      resetForm();
      await loadTasks();
    } catch (err) {
      setError(err.response?.data?.message || 'Save failed');
    }
  };

  const startEdit = (task) => {
    setEditingId(task.id);
    setForm({
      title: task.title,
      description: task.description || '',
      status: task.status,
      user_id: task.user_id?.toString() || '',
    });
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const deleteTask = async (id) => {
    if (!window.confirm('Delete this task?')) return;
    try {
      await api.delete(`/tasks/${id}`);
      // If last item on last page was deleted, step back a page
      if (tasks.length === 1 && page > 1) setPage(page - 1);
      else await loadTasks();
    } catch (err) {
      alert(err.response?.data?.error || 'Delete failed');
    }
  };

  return (
    <div style={styles.container}>
      <header style={styles.header}>
        <h2>{isAdmin ? 'All Tasks (Admin)' : 'My Tasks'}</h2>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
          <span>
            Hi, {user?.name}{' '}
            <span style={isAdmin ? styles.adminBadge : styles.userBadge}>
              {user?.role}
            </span>
          </span>
          <button onClick={logout} style={styles.logoutBtn}>Logout</button>
        </div>
      </header>

      {/* -------- Create / Edit Form -------- */}
      <form onSubmit={handleSubmit} style={styles.form}>
        <h3 style={{ margin: 0, width: '100%' }}>
          {editingId ? `Editing Task #${editingId}` : 'New Task'}
        </h3>

        <input
          placeholder="Title"
          value={form.title}
          onChange={(e) => setForm({ ...form, title: e.target.value })}
          style={{ ...styles.input, flex: '1 1 240px' }}
          required
        />

        <input
          placeholder="Description (optional)"
          value={form.description}
          onChange={(e) => setForm({ ...form, description: e.target.value })}
          style={{ ...styles.input, flex: '1 1 240px' }}
        />

        <select
          value={form.status}
          onChange={(e) => setForm({ ...form, status: e.target.value })}
          style={styles.input}
        >
          {STATUSES.map((s) => (
            <option key={s.value} value={s.value}>{s.label}</option>
          ))}
        </select>

        {isAdmin && !editingId && (
          <select
            value={form.user_id}
            onChange={(e) => setForm({ ...form, user_id: e.target.value })}
            style={styles.input}
            required
          >
            <option value="">Assign to…</option>
            {users.map((u) => (
              <option key={u.id} value={u.id}>{u.name} ({u.email})</option>
            ))}
          </select>
        )}

        <button type="submit" style={styles.button}>
          {editingId ? 'Update Task' : 'Create Task'}
        </button>

        {editingId && (
          <button type="button" onClick={resetForm} style={styles.cancelBtn}>
            Cancel
          </button>
        )}
      </form>

      {error && <p style={styles.error}>{error}</p>}

      {/* -------- Search & Filter Bar -------- */}
      <div style={styles.filterBar}>
        <input
          placeholder="🔍 Search by title…"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          style={{ ...styles.input, flex: 2 }}
        />
        <select
          value={status}
          onChange={(e) => setStatus(e.target.value)}
          style={{ ...styles.input, flex: 1 }}
        >
          <option value="">All statuses</option>
          {STATUSES.map((s) => (
            <option key={s.value} value={s.value}>{s.label}</option>
          ))}
        </select>
        {(search || status) && (
          <button
            onClick={() => { setSearch(''); setStatus(''); setPage(1); }}
            style={styles.clearBtn}
          >
            Clear
          </button>
        )}
      </div>

      {/* -------- Task List -------- */}
      {loading && <p>Loading…</p>}

      {!loading && tasks.length === 0 && (
        <p style={{ textAlign: 'center', color: '#666' }}>
          No tasks match your filters.
        </p>
      )}

      <ul style={styles.list}>
        {tasks.map((task) => (
          <li key={task.id} style={styles.item}>
            <div style={{ flex: 1 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 4 }}>
                <strong style={{
                  color: task.status === 'completed' ? '#888' : '#111',
                }}>
                  {task.title}
                </strong>
                <StatusBadge status={task.status} />
              </div>

              {task.description && (
                <div style={{ fontSize: 13, color: '#555', marginBottom: 4 }}>
                  {task.description}
                </div>
              )}

              <div style={{ fontSize: 11, color: '#999' }}>
                Created {new Date(task.created_at).toLocaleString()}
                {isAdmin && task.user && (
                  <> &middot; 👤 {task.user.name}</>
                )}
              </div>
            </div>

            <button onClick={() => startEdit(task)} style={styles.editBtn}>Edit</button>
            <button onClick={() => deleteTask(task.id)} style={styles.deleteBtn}>✕</button>
          </li>
        ))}
      </ul>

      {/* -------- Pagination -------- */}
      {meta && meta.last_page > 1 && (
        <div style={styles.pagination}>
          <button
            onClick={() => setPage((p) => Math.max(1, p - 1))}
            disabled={meta.current_page <= 1}
            style={styles.pageBtn}
          >
            ← Prev
          </button>

          <span style={{ fontSize: 13, color: '#555' }}>
            Page {meta.current_page} of {meta.last_page} &middot; {meta.total} task{meta.total !== 1 && 's'}
          </span>

          <button
            onClick={() => setPage((p) => Math.min(meta.last_page, p + 1))}
            disabled={meta.current_page >= meta.last_page}
            style={styles.pageBtn}
          >
            Next →
          </button>
        </div>
      )}
    </div>
  );
}

function StatusBadge({ status }) {
  const s = STATUSES.find((x) => x.value === status) || STATUSES[0];
  return (
    <span style={{
      background: s.color,
      color: 'white',
      padding: '2px 8px',
      borderRadius: 10,
      fontSize: 11,
      fontWeight: 600,
      textTransform: 'uppercase',
      letterSpacing: 0.3,
    }}>
      {s.label}
    </span>
  );
}

const styles = {
  container: { maxWidth: 800, margin: '0 auto', padding: 24 },
  header: { display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 20 },
  logoutBtn: { padding: '6px 12px', background: '#dc2626', color: 'white', border: 'none', borderRadius: 4, cursor: 'pointer' },
  form: { display: 'flex', flexWrap: 'wrap', gap: 8, marginBottom: 16, padding: 16, background: '#fafafa', borderRadius: 8 },
  input: { padding: 10, border: '1px solid #ddd', borderRadius: 4, fontSize: 14 },
  button: { padding: '10px 20px', background: '#2563eb', color: 'white', border: 'none', borderRadius: 4, cursor: 'pointer' },
  cancelBtn: { padding: '10px 20px', background: '#6b7280', color: 'white', border: 'none', borderRadius: 4, cursor: 'pointer' },
  filterBar: { display: 'flex', gap: 8, marginBottom: 16, flexWrap: 'wrap' },
  clearBtn: { padding: '10px 16px', background: '#e5e7eb', border: 'none', borderRadius: 4, cursor: 'pointer' },
  list: { listStyle: 'none', padding: 0 },
  item: { display: 'flex', alignItems: 'flex-start', gap: 8, padding: 12, background: 'white', borderRadius: 6, marginBottom: 8, boxShadow: '0 1px 3px rgba(0,0,0,0.08)' },
  editBtn: { padding: '4px 10px', background: '#f3f4f6', border: '1px solid #d1d5db', borderRadius: 4, cursor: 'pointer', fontSize: 12 },
  deleteBtn: { background: 'transparent', border: 'none', color: '#dc2626', fontSize: 18, cursor: 'pointer', padding: '0 6px' },
  pagination: { display: 'flex', justifyContent: 'center', alignItems: 'center', gap: 16, marginTop: 20 },
  pageBtn: { padding: '6px 14px', background: 'white', border: '1px solid #d1d5db', borderRadius: 4, cursor: 'pointer' },
  adminBadge: { background: '#7c3aed', color: 'white', padding: '2px 8px', borderRadius: 10, fontSize: 11, textTransform: 'uppercase' },
  userBadge: { background: '#6b7280', color: 'white', padding: '2px 8px', borderRadius: 10, fontSize: 11, textTransform: 'uppercase' },
  error: { color: 'red', fontSize: 13, marginBottom: 12 },
};