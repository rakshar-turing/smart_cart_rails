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
