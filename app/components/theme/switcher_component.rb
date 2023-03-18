class Theme::SwitcherComponent < ApplicationComponent
  def initialize(current_theme:, type: :default)
    @current_theme = current_theme
    @type = type
  end

  def text
   if current_theme.name == "dark"
    "Turn on Light mode"    
   else
    "Turn on Dark mode"        
   end
  end

  def other_theme
    Users::Theme.all.find { |other_theme| other_theme.name != current_theme.name }
  end

  def icon_only?
    type == :icon_only
  end

  def mobile?
    type == :mobile
  end

  private

  attr_reader :current_theme, :type
end
