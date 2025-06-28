# frozen_string_literal: true

Puppet::Type.type(:chattr).provide(:linux) do
  desc <<-DOC
    The Linux provider for the chattr custom type.
  DOC

  commands chattr: 'chattr'
  commands lsattr: 'lsattr'

  def self.prefetch(resources)
    resources.each_key do |name|
      if File.file?(name) || File.directory?(name)
        attr = lsattr('-d', name).split.first

        Puppet.debug("read file attributes #{attr} for #{name}")

        Puppet.fail('Unable to parse lsattr output') unless %r{^[aAcCdDeEFiIjmNPsStTuxV-]+$}.match?(attr)

        resources[name].provider = new(
          name: name,
          immutable: attr.include?('i') ? :true : :false
        )
      else
        Puppet.notice('File attributes can only be set for regular files or directories')
      end
    end
  end

  def flush
    args = []

    # Add command argument for each attribute
    args << '+a' if @resource[:append_only] == :true
    args << '-a' if @resource[:append_only] == :false
    args << '+i' if @resource[:immutable] == :true
    args << '-i' if @resource[:immutable] == :false

    # Change file attributes if not in sync
    chattr(args, @resource[:file]) unless args.empty?
  end

  mk_resource_methods
end
