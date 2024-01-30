# chattr.rb --- Manage file attributes
#
Puppet::Type.newtype(:chattr) do
  desc <<-EOT
    @summary Manage file attributes

    This type enables Puppet to manage file attributes. Normally Linux
    recognizes the following attributes:

        a - append only
        A - no atime updates
        c - compressed
        C - no copy on write
        d - no dump
        D - synchronous directory updates
        e - extent format
        F - case-insensitive directory lookups
        i - immutable
        j - data journalling
        m - don't compress
        P - project hierarchy
        s - secure deletion
        S - synchronous updates
        t - no tail-merging
        T - top of directory hierarchy
        u - undeletable
        x - direct access for files

    Not all file attributes are supported by all file systems. Also only
    a subset of these attributes have been implemented by this type.

    The following attributes are read-only and can not be modified:

        E - encrypted
        I - indexed directory
        N - inline data
        V - verity

    **Note**

    Setting the immutable attribute also prevents any future file
    modifications by Puppet. Setting this attribute might cause errors in the
    future if the file content is also managed by Puppet.

    @example Set the immutable file attribute

        chattr { '/etc/machine-id':
          immutable => true,
        }

    **Autorequires**

    If the file is also managed by Puppet this type will autorequire the file.

  EOT

  def munge_boolean(value)
    case value
    when true, 'true', :true
      :true
    when false, 'false', :false
      :false
    else
      raise Puppet::Error, 'munge_boolean only takes booleans'
    end
  end

  newparam(:file, namevar: true) do
    desc 'The file for which the file attributes should be managed.'

    validate do |value|
      unless Puppet::Util.absolute_path?(value)
        raise Puppet::Error, "File paths must be fully qualified, not '#{value}'"
      end
    end
  end

  newproperty(:append_only, boolean: true) do
    desc <<-DOC
      Specifies the value of the append only file attribute.

      A file with the `a` attribute can only be opened in append mode for
      writing.
    DOC

    newvalues(:true, :false)

    munge do |value|
      @resource.munge_boolean(value)
    end
  end

  newproperty(:immutable, boolean: true) do
    desc <<-DOC
      Specifies the value of the immutable file attribute.

      A file with the `i` attribute cannot be modified: it cannot be deleted
      or renamed, no link can be created to this file, most of the file's
      metadata can not be modified, and the file can not be opened in write
      mode.
    DOC

    newvalues(:true, :false)

    munge do |value|
      @resource.munge_boolean(value)
    end
  end

  autorequire(:file) { self[:file] }
end
