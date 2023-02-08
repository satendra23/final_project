class Category < ApplicationRecord 
    has_many :article_categories, dependent: :destroy
    has_many :articles, through: :article_categories
    validates :name, presence: true, uniqueness: { case_sensitive: false }
end
