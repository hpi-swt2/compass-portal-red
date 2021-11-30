class IndoorController < ApplicationController
    def demo
        @point = [50, 70]
        @line = [0, 0, 20, 50]
    end
end
