class UserSetting < ApplicationRecord
  belongs_to :user

  enum notification_setting: {notify_on: true, notify_off: false}
  enum email_setting: {email_on: true, email_off: false}
  enum language: {vi: "vi", en: "en", ja: "ja"}
end
