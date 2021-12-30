class HealthAndMonitoringController < ApplicationController
    def healthcheck
        head 200
    end
end