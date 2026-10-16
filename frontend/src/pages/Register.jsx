import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

export default function Register() {
  const { register } = useAuth();
  const navigate = useNavigate();
  const [form, setForm] = useState({
    name: '', email: '', password: '', password_confirmation: '',
  });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    if (form.password !== form.password_confirmation) {
      return setError('Passwords do not match');
    }
    setLoading(true);
    try {
      await register(form.name, form.email, form.password, form.password_confirmation);
      navigate('/tasks');
    } catch (err) {
      const errors = err.response?.data?.errors;
      setError(errors ? Object.values(errors).flat().join(' ') : 'Registration failed');
    } finally {
      setLoading(false);
    }
  };

  const update = (k) => (e) => setForm({ ...form, [k]: e.target.value });

  return (
    <div style={styles.container}>
      <form onSubmit={handleSubmit} style={styles.card}>
        <h2>Register</h2>
        {error && <p style={styles.error}>{error}</p>}
        <input placeholder="Name" value={form.name} onChange={update('name')} required style={styles.input} />
        <input type="email" placeholder="Email" value={form.email} onChange={update('email')} required style={styles.input} />
        <input type="password" placeholder="Password (min 8 chars)" value={form.password} onChange={update('password')} required style={styles.input} />
        <input type="password" placeholder="Confirm Password" value={form.password_confirmation} onChange={update('password_confirmation')} required style={styles.input} />
        <button type="submit" disabled={loading} style={styles.button}>
          {loading ? 'Registering...' : 'Register'}
        </button>
        <p>Already have an account? <Link to="/login">Login</Link></p>
      </form>
    </div>
  );
}

const styles = {
  container: { display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '100vh', background: '#f5f5f5' },
  card: { background: 'white', padding: 32, borderRadius: 8, boxShadow: '0 2px 8px rgba(0,0,0,0.1)', width: 360, display: 'flex', flexDirection: 'column', gap: 12 },
  input: { padding: 10, border: '1px solid #ddd', borderRadius: 4, fontSize: 14 },
  button: { padding: 10, background: '#2563eb', color: 'white', border: 'none', borderRadius: 4, cursor: 'pointer', fontSize: 14 },
  error: { color: 'red', margin: 0, fontSize: 13 },
};