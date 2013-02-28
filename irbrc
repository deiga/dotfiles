#!/usr/bin/ruby

require 'irb/completion'

# Save History between irb sessions
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# # Misc IRB settings
IRB.conf[:USE_READLINE] = true      # fixes behaviour of delete and backspace keys - see https://gist.github.com/3623012 on how to install readline with rbenv
IRB.conf[:AUTO_INDENT]  = false     # automatically indent code on multiple lines
IRB.conf[:PROMPT_MODE]  = :SIMPLE   # actually it doesn't make any difference if the dynamic prompt is enabled

class Object
    # list methods which aren't in superclass
    def local_methods(obj = self)
        (obj.methods - obj.class.superclass.instance_methods).sort
    end

    # print documentation
    #
    #   ri 'Array#pop'
    #   Array.ri
    #   Array.ri :pop
    #   arr.ri :pop
    def ri(method = nil)
        unless method && method =~ /^[A-Z]/ # if class isn't specified
            klass = self.kind_of?(Class) ? name : self.class.name
            method = [klass, method].compact.join('#')
        end
        system 'ri', method.to_s
    end
end

# Colorise the output
# https://github.com/blackwinter/wirble
require 'wirble'
Wirble.init
Wirble.colorize

def copy(str)
    IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

def copy_history
    history = Readline::HISTORY.entries
    index = history.rindex("exit") || -1
    content = history[(index+1)..-2].join("\n")
    puts content
    copy content
end

def paste
    `pbpaste`
end
