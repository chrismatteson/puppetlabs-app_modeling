require_relative '../app_modeling_monitor'
require 'puppet/ssl'
require 'puppet/ssl/certificate'

Puppet::Type.type(:nodes).provide(:nodes,
                                 :parent => Puppet::Provider::AppModelingMonitor) do

  def validate
    nodes = resource[:nodes].delete("[ ]").split(",")
    begin
      nodes.each do |node|
        Puppet::SSL::CertificateAuthority.new.verify("#{node}")
      end
      return true
    rescue Puppet::SSL::CertificateAuthority::CertificateVerificationError
    end
  end
end
