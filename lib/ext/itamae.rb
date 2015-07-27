module Itamae
  class Node
    attr_reader :backend
  end
  module Backend
    class Ssh
      def host
        @options['host']
      end

      def clear
        @backend.get_config(:ssh).close
        @backend.set_config(:ssh, nil)
        @backend.set_config(:scp, nil)
      end
    end
  end
end
