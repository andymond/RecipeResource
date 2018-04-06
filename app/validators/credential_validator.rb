class CredentialValidator < ActiveModel::Validator

  def validate(record)
    if (record.app_credential.nil? || record.app_credential.password_digest.nil?) && (record.google_credential.nil? || record.google_credential.uid.nil?)
      record.errors[:no_credential_error] << "user must have credentials"
    end
  end

end
