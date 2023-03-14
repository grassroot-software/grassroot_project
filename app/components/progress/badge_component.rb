class Progress::BadgeComponent < ApplicationComponent
  RADIUS = 9

  delegate :user_signed_in?, :percentage_completed_by_user, to: :helpers

  # rubocop:disable Metrics/ParameterLists, Layout/LineLength
  def initialize(course:, current_user:, url:, show_badge: true, background_color: 'bg-white dark:bg-gray-900', size: :default)
    @course = course
    @current_user = current_user
    @url = url
    @show_badge = show_badge
    @background_color = background_color
    @size = size
  end
  # rubocop:enable Metrics/ParameterLists, Layout/LineLength

  private

  attr_reader :course, :current_user, :url, :show_badge, :background_color, :size

  def circumference
    RADIUS * 2 * Math::PI
  end

  def badge
    @course.badge_uri || fallback_icon
  end

  def borderless_badge
    badge_uri = @course.badge_uri.split('.').first

    "badges/#{badge_uri}-borderless.svg" || fallback_icon
  end

  def fallback_icon
    'icons/grassroot-icon.svg'
  end

  def show_badge?
    if show_badge || current_user.progress_for(course).completed?
      'visible'
    else
      'invisible'
    end
  end
end
