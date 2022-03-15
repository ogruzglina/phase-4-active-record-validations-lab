class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: ["Fiction", "Non-Fiction"] }
    validate :clickbait?

    CLICKBAIT_PATTERNS = [
        /Won't Believe/i,  
        /Secret/i,
        /Top \d/i,
        /Guess/i
    ] 
    # i - (insensitive) makes the whole expression case-insensitive (for instance /aBc/i would match AbC)
    # \d matches any single digit 
    # /any_word/ - it will check only this sequence of characters between //
    def clickbait?
        if CLICKBAIT_PATTERNS.none? { |pat| pat.match title } # Returns true if none of the elements match the given block.
            errors.add(:title, "must be clickbait")
        end
    end
end
