A simple **Ruby on Rails e-commerce app** built with a clean **MVC architecture**, running entirely inside **Docker**.  
The first version includes basic product listing and management features — designed to be easily extended with new features through future PRs.

---

## Technical Overview

- **Rails 7 MVC structure**
- **Dockerized development environment**
- **PostgreSQL database**
- Product model with attributes: `name`, `price`
- Database seeds with sample products
- RSpec test suite
- Ready for CI/CD or GitHub Actions integration

## Project structure

smart_cart_rails/
├── app/
│ ├── controllers/
│ │ └── products_controller.rb
│ ├── models/
│ │ └── product.rb
│ └── views/
│ └── products/
│ ├── index.html.erb
│ └── show.html.erb
├── db/
│ ├── migrate/
│ │ └── 20251028120000_create_products.rb
│ └── seeds.rb
├── config/
│ ├── database.yml
│ └── routes.rb
├── Dockerfile
├── docker-compose.yml
├── Gemfile
└── README.md

## Commands

To run rspec -> sudo docker-compose exec web bundle exec rspec
Rails console -> sudo docker-compose exec web rails console

## Features

1️⃣ User Authentication & Roles Secure login/signup (Devise + JWT + Roles: Admin, Customer)
2️⃣ Shopping Cart System Persistent cart per user (even for guests)
3️⃣ Order Management Checkout flow, order history, and payments (Stripe)
4️⃣ Admin Dashboard Manage products, categories, users (ActiveAdmin or custom dashboard)
5️⃣ Inventory & Stock Tracking Auto-update stock on order, prevent overselling
6️⃣ Background Jobs Use Sidekiq for sending order emails, async jobs
7️⃣ API + Mobile Integration Provide REST/JSON APIs for mobile apps
8️⃣ Search & Filters Full-text search with pg_search + filters by category/price
9️⃣ Tests & CI/CD RSpec, FactoryBot, GitHub Actions integration
🔟 Caching & Performance Redis caching for product listing
