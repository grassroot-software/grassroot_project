require 'rails_helper'

RSpec.describe LessonsHelper do
  describe '#github_edit_url' do
    let(:lesson) { create(:lesson) }

    it 'returns the github edit url for the lesson' do
      puts lesson.title
      expect(helper.github_edit_url(lesson)).to eql(
        'https://github.com/grassroot-software/grassroot_curriculum/edit/main/lesson_course/lesson_title.md'
      )
    end
  end
end
