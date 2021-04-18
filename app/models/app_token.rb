class AppToken < ApplicationRecord
  validate :singleton_guard_must_be_zero

  def self.instance
    first_or_create!(singleton_guard: 0)
  end

  private

  def singleton_guard_must_be_zero
    errors.add(:base, 'can only be one instance') unless singleton_guard.zero?
  end
end