class ApplicationController < ActionController::Base
  before_action :set_locale
  include ScheduleHelper

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def search search, objects, key1, key2
    if search.blank?
      objects.paginate page: params[:page], per_page: Settings.per_page.long
    else
      objects.where("#{key1} like ? OR #{key2} like ?",
        "%#{search}%", "%#{search}").paginate page: params[:page],
          per_page: Settings.per_page.long
    end
  end
end
