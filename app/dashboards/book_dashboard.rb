require "administrate/base_dashboard"

class BookDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    author: Field::String,
    carts: Field::HasMany,
    category: Field::BelongsTo,
    description: Field::Text,
    editor: Field::BelongsTo,
    image_url: Field::String,
    isbn: Field::String,
    joint_table_cart_books: Field::HasMany,
    joint_table_order_books: Field::HasMany,
    orders: Field::HasMany,
    price_code: Field::BelongsTo,
    quantity: Field::Number,
    release_date: Field::DateTime,
    title: Field::String,
    tva: Field::Number.with_options(decimals: 2),
    wishlists: Field::HasMany,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    title
    author
    category
    quantity
    price_code
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    author
    carts
    category
    description
    editor
    image_url
    isbn
    joint_table_cart_books
    joint_table_order_books
    orders
    price_code
    quantity
    release_date
    title
    tva
    wishlists
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    author
    carts
    category
    description
    editor
    image_url
    isbn
    joint_table_cart_books
    joint_table_order_books
    orders
    price_code
    quantity
    release_date
    title
    tva
    wishlists
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how books are displayed
  # across all pages of the admin dashboard.
  #
end
