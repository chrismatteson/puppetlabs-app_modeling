Puppet::Type.newtype :nodes, is_capability: true do

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, namevar: true) do
    desc 'An arbitrary name used as the identity of the resource.'
  end

  newparam(:timeout) do
    desc 'Time before timing out the resource (seconds)'
    defaultto 60

    validate do |value|
      Float(value)
    end

    munge do |value|
      Float(value)
    end
  end

  newparam(:ping_interval) do
    desc 'Time to sleep before attempting to try a connection again (second)'
    defaultto 1

    validate do |value|
      Float(value)
    end

    munge do |value|
      Float(value)
    end
  end

end
