require_relative '../app_modeling_monitor'
require 'puppet/ssl'
require 'puppet/ssl/certificate'

Puppet::Type.type(:nodes).provide(:nodes,
                                 :parent => Puppet::Provider::AppModelingMonitor) do
  def validate
    begin
      Puppet.notice "validate"
      Puppet.notice resource[:name]
      Puppet::SSL::CertificateAuthority.new.verify(resource[:name])
      return true
    rescue Puppet::SSL::CertificateAuthority::CertificateVerificationError
      notice_for_failure('revoked')
    end
  end
end
