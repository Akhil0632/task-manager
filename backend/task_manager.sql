-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 16, 2026 at 01:25 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `task_manager`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` varchar(255) NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` smallint(5) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_10_16_061028_create_tasks_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('pending','in_progress','completed') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`id`, `user_id`, `title`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'Et qui nesciunt aut quae', 'Voluptatem sint non ut nam quia ut. Et placeat perspiciatis nulla labore molestias. Magnam soluta ducimus quaerat quis laudantium. Consequuntur ut molestias eum aut nostrum alias.', 'in_progress', '2026-10-12 02:25:37', '2026-10-16 07:54:50'),
(2, 2, 'Consequatur est nobis ducimus', NULL, 'in_progress', '2026-08-22 21:42:32', '2026-10-16 07:54:50'),
(3, 2, 'Minima aliquid voluptatem facilis', 'Quibusdam maiores et sit recusandae inventore nihil consequuntur. Pariatur nihil ipsum soluta quod sunt. Quaerat quis harum maiores aspernatur. Maiores quaerat eos animi laudantium sint.', 'in_progress', '2026-08-12 11:00:15', '2026-10-16 07:54:50'),
(4, 2, 'Culpa et aut rerum quas blanditiis', 'Quam accusamus sed similique ea perspiciatis. Quae ipsum et reiciendis est qui laborum. Cupiditate labore quidem atque.', 'in_progress', '2026-09-29 23:53:16', '2026-10-16 07:54:50'),
(5, 2, 'Non maiores qui id', 'Repellat velit omnis voluptatem veniam neque nesciunt. Reiciendis necessitatibus dolorem corrupti necessitatibus distinctio. Consectetur eaque totam eos sed ipsam debitis.', 'in_progress', '2026-09-28 20:17:14', '2026-10-16 07:54:50'),
(6, 2, 'Voluptate iusto laudantium voluptas aut', 'Expedita est dolorem suscipit sunt velit perferendis in dolores. Expedita omnis tempore aliquid porro minima minima.', 'in_progress', '2026-08-27 13:11:06', '2026-10-16 07:54:50'),
(7, 2, 'Rem iure consequuntur ut provident est', NULL, 'in_progress', '2026-07-30 14:21:05', '2026-10-16 07:54:50'),
(8, 2, 'Dolorem magni pariatur dolorem architecto', NULL, 'in_progress', '2026-08-06 19:06:02', '2026-10-16 07:54:50'),
(9, 2, 'Itaque aut iure qui officia', 'Temporibus ex rerum accusamus nam velit illum reiciendis. Pariatur alias et qui autem laboriosam ut qui. Aut hic numquam laboriosam sapiente. Repellat aliquam est ab laboriosam voluptates inventore.', 'pending', '2026-08-05 14:30:57', '2026-10-16 07:54:50'),
(10, 2, 'Fugiat incidunt possimus ea unde dolores', 'Ut illo voluptas eum voluptatem dolorem cupiditate. Dolores itaque possimus molestiae. Minima sequi dolorem exercitationem autem.', 'pending', '2026-09-12 00:37:04', '2026-10-16 07:54:50'),
(11, 2, 'Dolorem molestiae vero', 'Qui sint at culpa quia facilis. Ratione aliquid dignissimos voluptatem eaque et assumenda excepturi. Inventore at corporis qui qui possimus.', 'pending', '2026-07-22 21:36:26', '2026-10-16 07:54:50'),
(12, 2, 'Sed et accusamus sunt', 'Veritatis architecto sunt enim odit sint distinctio et voluptas. Voluptatibus pariatur maxime dolore doloribus sapiente. Magni sit sequi maiores voluptatem sed nulla.', 'pending', '2026-09-10 22:51:22', '2026-10-16 07:54:50'),
(13, 2, 'Ipsum omnis molestiae quam', 'Ut in nihil impedit optio omnis. Earum in nobis quidem qui quis velit. Est dolores omnis esse vel quae.', 'completed', '2026-09-19 07:24:44', '2026-10-16 07:54:50'),
(14, 2, 'Assumenda voluptatem tempora quo', 'Dolor est sunt earum tenetur veritatis. Fugit ut molestiae culpa sunt dolorem iste. Natus fugiat possimus ut nesciunt. Quia rerum omnis sunt sequi.', 'completed', '2026-07-30 07:36:00', '2026-10-16 07:54:50'),
(15, 2, 'Autem eaque suscipit', 'Itaque iste explicabo omnis veniam. Expedita et eum deserunt. Est molestias est delectus molestias sint officiis. Accusantium iusto voluptatem qui sed.', 'completed', '2026-09-30 10:29:09', '2026-10-16 07:54:50'),
(16, 3, 'Aut dolorem quia quibusdam', 'Beatae suscipit necessitatibus iusto tenetur et sed incidunt. Deserunt similique nostrum est. Neque officiis placeat quis ut.', 'completed', '2026-08-25 17:42:19', '2026-10-16 07:54:50'),
(17, 3, 'Omnis maxime dolorem unde fugit eum', NULL, 'completed', '2026-09-19 03:47:14', '2026-10-16 07:54:50'),
(18, 3, 'Qui sit velit recusandae', 'Est atque neque non necessitatibus. Ducimus est sint autem at. Dolores sunt corrupti vero harum ut. Qui nulla ex error.', 'completed', '2026-10-03 00:14:24', '2026-10-16 07:54:50'),
(19, 3, 'Tenetur cumque dolores corporis sed quibusdam', 'Ut provident ab deleniti cumque distinctio sequi mollitia. Odio cum esse et ratione neque distinctio. Quis ipsa earum voluptas repudiandae. Quaerat voluptatem veniam reiciendis architecto laboriosam corrupti ut ipsam.', 'completed', '2026-07-16 17:32:48', '2026-10-16 07:54:50'),
(20, 3, 'Non tenetur aut fugit delectus', NULL, 'completed', '2026-09-05 19:28:04', '2026-10-16 07:54:50'),
(21, 3, 'Alias nemo nihil harum possimus', NULL, 'completed', '2026-08-03 07:12:55', '2026-10-16 07:54:50'),
(22, 3, 'Sed facilis et', 'Dolores quo pariatur iusto nulla. Beatae iure quia eaque voluptatem officiis provident. Qui voluptas optio et aut autem aut. Non inventore consequuntur unde quisquam nostrum assumenda. Natus vitae dolorum quo sit occaecati.', 'completed', '2026-09-01 07:49:06', '2026-10-16 07:54:50'),
(23, 3, 'Ut assumenda laudantium qui in tempore', 'Ut ea ipsa consequatur nisi quis est amet vel. Est ut aperiam nobis deserunt fugit vitae. Provident numquam nemo vitae aut. Consequatur laudantium eum ut porro.', 'pending', '2026-08-15 10:01:49', '2026-10-16 07:54:50'),
(24, 3, 'Laudantium quo ut nisi et', NULL, 'pending', '2026-07-22 23:58:46', '2026-10-16 07:54:50'),
(25, 3, 'Voluptas ut deleniti fuga', NULL, 'pending', '2026-09-19 09:42:36', '2026-10-16 07:54:50'),
(26, 3, 'Sint laborum eveniet hic sequi', 'Ut est nam alias. Similique soluta laboriosam autem. Blanditiis mollitia possimus aut commodi vel sunt et. Molestiae voluptatem omnis rerum molestiae delectus rerum voluptate nesciunt.', 'in_progress', '2026-08-28 23:17:03', '2026-10-16 07:54:50'),
(27, 3, 'Vero suscipit maxime a', 'Eum ut non vel. Voluptates doloremque quo fuga quibusdam rerum magni. Consequatur autem dolor sit sed quasi.', 'in_progress', '2026-08-27 10:34:14', '2026-10-16 07:54:50'),
(28, 4, 'Velit ea maiores', NULL, 'in_progress', '2026-10-03 21:59:08', '2026-10-16 07:54:50'),
(29, 4, 'Necessitatibus ipsa soluta blanditiis sed', 'Aut nam voluptatem neque nulla cumque. In adipisci cupiditate et eum ut. Reiciendis voluptatem nihil tempora non eaque. A natus quae eligendi nihil ullam quis.', 'pending', '2026-10-05 02:31:49', '2026-10-16 07:54:50'),
(30, 4, 'Dolorem aut beatae hic ipsa consectetur', NULL, 'completed', '2026-09-08 06:15:04', '2026-10-16 07:54:50'),
(31, 4, 'Enim nam sint', 'Consequatur autem voluptates et autem necessitatibus sit sequi aut. Et voluptate consectetur rerum cum. Nesciunt accusamus aut non sed alias quod quibusdam quisquam.', 'completed', '2026-10-14 12:17:00', '2026-10-16 07:54:50'),
(32, 5, 'Quia non reprehenderit enim sunt libero', 'Cupiditate fugit debitis nobis aliquam modi qui odio amet. Corporis aspernatur dolores dolore ad est quod eveniet. Inventore ab accusantium odit vel ea quos minima.', 'in_progress', '2026-07-25 16:31:31', '2026-10-16 07:54:50'),
(33, 5, 'Porro porro eligendi fugiat vero', 'Doloribus exercitationem est nam amet. Reiciendis dolores beatae et esse quia. Id quia voluptatibus laboriosam.', 'pending', '2026-09-05 14:12:40', '2026-10-16 07:54:50'),
(34, 5, 'Error quis animi', 'Dolorum deserunt fuga qui nam eum tempore. Reiciendis soluta inventore expedita commodi aspernatur accusamus in. Totam maiores natus doloribus.', 'completed', '2026-10-03 10:04:21', '2026-10-16 07:54:50'),
(35, 6, 'Cupiditate sit laboriosam qui sit fugit', 'Velit eum maiores sint excepturi repellat voluptates totam. Et qui dolore non distinctio consequuntur itaque id. Hic voluptatem et sapiente id facilis voluptas. Occaecati explicabo minus ullam eum sequi voluptatibus enim unde.', 'in_progress', '2026-07-25 00:20:08', '2026-10-16 07:54:50'),
(36, 6, 'Fugiat optio eos reprehenderit saepe reprehenderit', NULL, 'completed', '2026-07-21 05:26:50', '2026-10-16 07:54:50'),
(37, 6, 'Expedita est omnis totam enim', 'Maiores facilis ut magnam voluptatibus maiores accusamus. Magnam est animi qui et fuga aspernatur. Quos quia unde perferendis voluptatum excepturi.', 'in_progress', '2026-08-02 15:34:14', '2026-10-16 07:54:50'),
(38, 7, 'Harum culpa ut quo qui fugit', 'Praesentium commodi aut aut qui. Rerum voluptatem voluptas sit ratione optio odio ad. Placeat voluptas impedit officia vel incidunt eos totam. Qui et placeat numquam maiores ipsum. Et ut optio consequatur rerum tenetur rerum provident eius.', 'in_progress', '2026-07-28 05:25:51', '2026-10-16 07:54:50'),
(39, 7, 'Repellat commodi et ut', 'Vel quod ullam voluptatem qui sequi in cumque. Debitis voluptas molestias id. Quasi quae enim dolores voluptatem.', 'in_progress', '2026-08-23 04:59:09', '2026-10-16 07:54:50'),
(40, 7, 'Et deleniti in consequatur dignissimos accusantium', NULL, 'completed', '2026-08-18 05:00:45', '2026-10-16 07:54:50'),
(41, 7, 'Laboriosam nihil est aliquam in', 'Suscipit id nihil atque veritatis optio repellendus aut consequatur. Culpa ab possimus nobis reprehenderit quisquam ipsam ut. Est ex ut vitae consequatur reiciendis.', 'pending', '2026-08-10 02:17:59', '2026-10-16 07:54:50'),
(42, 7, 'Ratione sapiente temporibus sed aut', 'Nemo ea quod esse officiis consequatur voluptatum et est. Dicta sunt veritatis eum illum aliquam labore. Sit harum temporibus eos sunt ut ut fugiat. Est exercitationem fuga perspiciatis dolor eius sapiente.', 'completed', '2026-10-04 21:53:35', '2026-10-16 07:54:50'),
(43, 8, 'Voluptas dignissimos ut et ea', 'Iste neque rem et vel doloremque. Et alias animi ab est voluptas dolor qui. Dolor dolore veniam ea ex eligendi. Vel nostrum praesentium laudantium consequuntur labore iure quia tempore.', 'pending', '2026-08-10 22:29:09', '2026-10-16 07:54:50'),
(44, 8, 'Quasi iusto numquam', 'Ea est vero provident eligendi hic eos. Totam id voluptas quas soluta aliquam.', 'completed', '2026-10-10 02:12:36', '2026-10-16 07:54:50'),
(45, 9, 'Quaerat harum voluptate aspernatur aut', 'Magnam et rem dolores qui mollitia modi. Sed aut molestias animi modi cumque. Ut iure sit atque.', 'completed', '2026-08-13 00:25:13', '2026-10-16 07:54:50'),
(46, 9, 'Perspiciatis aut sit cumque', 'Non earum ex nostrum qui quia. Ratione dicta architecto et vel. Est quia sed quo molestiae dolorum quam dolore. Ullam maiores et porro corrupti quis.', 'pending', '2026-07-22 21:06:59', '2026-10-16 07:54:50'),
(47, 9, 'Consectetur vel quod', 'Itaque sed reiciendis ex. Qui quis qui ut animi. Minus animi saepe facere. Pariatur possimus necessitatibus rerum quo.', 'in_progress', '2026-08-26 16:48:55', '2026-10-16 07:54:50'),
(48, 1, 'Totam omnis voluptate veritatis est', 'Ipsum enim odit debitis numquam. Quis possimus mollitia veritatis iusto rem.', 'in_progress', '2026-09-04 06:25:26', '2026-10-16 07:54:50'),
(49, 1, 'Et et neque enim', 'Iusto eaque temporibus exercitationem quia dolores. Iste consequatur non voluptatem impedit assumenda. A omnis illo soluta quae aspernatur et. Ratione iure eius architecto vero doloribus veritatis quasi.', 'completed', '2026-07-18 13:06:05', '2026-10-16 07:54:50'),
(50, 1, 'Consequatur vel officia iusto', 'Quibusdam voluptatum placeat officia fuga sapiente quisquam. Quos non molestiae qui recusandae. Architecto temporibus voluptas et dolores nobis quo. Saepe amet sunt nobis atque et.', 'in_progress', '2026-09-04 18:25:20', '2026-10-16 07:54:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `role`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin User', 'admin@example.com', '2026-10-16 07:54:49', 'admin', '$2y$12$5i6x6px9aIUp3VIGWjIgauj0bRmSswnIHKljAM7boG570b1GNPije', NULL, '2026-10-16 07:54:49', '2026-10-16 07:54:49'),
(2, 'Alice Johnson', 'alice@example.com', '2026-10-16 07:54:49', 'user', '$2y$12$0lrRcklC2CFecnr3F7xtiuXcXJ/RlZDuUjyJm4xOrDkmFVCnFQBAq', NULL, '2026-10-16 07:54:49', '2026-10-16 07:54:49'),
(3, 'Bob Smith', 'bob@example.com', '2026-10-16 07:54:49', 'user', '$2y$12$R22qCIEfrHO52NeB3WMCFO3m443f9XUXCN4m2pI07ba6e1Q51ztUi', NULL, '2026-10-16 07:54:49', '2026-10-16 07:54:49'),
(4, 'Julio Beier DVM', 'hailee.heidenreich@example.net', '2026-10-16 07:54:50', 'user', '$2y$12$EuM7TFLxtRgxjAvMOPYaYum9SAJddtDHSVqq1SDDpkXIgQnGGToY.', 'cdLTNpr6CH', '2026-10-16 07:54:50', '2026-10-16 07:54:50'),
(5, 'Elva Smith', 'pacocha.ashley@example.com', '2026-10-16 07:54:50', 'user', '$2y$12$EuM7TFLxtRgxjAvMOPYaYum9SAJddtDHSVqq1SDDpkXIgQnGGToY.', '7QcPM0Hh57', '2026-10-16 07:54:50', '2026-10-16 07:54:50'),
(6, 'Ms. Whitney Schuster Sr.', 'retha13@example.net', '2026-10-16 07:54:50', 'user', '$2y$12$EuM7TFLxtRgxjAvMOPYaYum9SAJddtDHSVqq1SDDpkXIgQnGGToY.', 'yJyssagHdF', '2026-10-16 07:54:50', '2026-10-16 07:54:50'),
(7, 'Courtney Gislason', 'cartwright.amanda@example.org', '2026-10-16 07:54:50', 'user', '$2y$12$EuM7TFLxtRgxjAvMOPYaYum9SAJddtDHSVqq1SDDpkXIgQnGGToY.', '5twfFLjjYJ', '2026-10-16 07:54:50', '2026-10-16 07:54:50'),
(8, 'Cassandre O\'Conner', 'mariane86@example.com', '2026-10-16 07:54:50', 'user', '$2y$12$EuM7TFLxtRgxjAvMOPYaYum9SAJddtDHSVqq1SDDpkXIgQnGGToY.', 'EIJ3Prh0QK', '2026-10-16 07:54:50', '2026-10-16 07:54:50'),
(9, 'Norval Wintheiser', 'deonte.yundt@example.com', '2026-10-16 07:54:50', 'admin', '$2y$12$EuM7TFLxtRgxjAvMOPYaYum9SAJddtDHSVqq1SDDpkXIgQnGGToY.', 'vOErfA2sIV', '2026-10-16 07:54:50', '2026-10-16 07:54:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  ADD KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tasks_user_id_foreign` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
