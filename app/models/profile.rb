class Profile < ActiveRecord::Base
  belongs_to :user

  validate :first_or_last
  validate :gender_choice
  validate :correct_gender

  def first_or_last
    if first_name.nil? && last_name.nil?
      errors.add(:first_name, "Need at least a first or last name")
    end
  end

  def gender_choice
    if gender != "female" && gender != "male"
      errors.add(:gender, "Gender should be either male or female")
    end
  end

  def correct_gender
    if gender == "male" && first_name == "Sue"
      errors.add(:gender, "A male should not be named Sue!")
    end
  end

  def self.get_all_profiles(min, max)
    where("birth_year BETWEEN :min_year AND :max_year", min_year: min, max_year: max).order("birth_year")
  end
end
