Analytics = AnalyticsRuby       # Alias for convenience
Analytics.init({
    secret: '655jjdwlo6',          # The write key for josselinperrus/parisenbreves
    on_error: Proc.new { |status, msg| print msg }  # Optional error handler
})