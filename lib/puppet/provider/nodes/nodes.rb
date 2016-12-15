require_relative '../app_modeling_monitor'
require 'puppet/ssl'
require 'puppet/ssl/certificate'

Puppet::Type.type(:nodes).provide(:nodes,
                                 :parent => Puppet::Provider::AppModelingMonitor) do

  def validate
    begin
      Puppet::SSL::CertificateAuthority.new.verify(name)
      return 'signed'
    rescue Puppet::SSL::CertificateAuthority::CertificateVerificationError
      return 'revoked'
    end
  end
end
