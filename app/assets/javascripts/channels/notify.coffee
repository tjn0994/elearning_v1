App.notify = App.cable.subscriptions.create "NotifyChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    this.update_counter(data.counter)

  update_counter: (counter) ->
    $counter = $('#notification-counter')
    val = parseInt $counter.text()
    val++
    $counter
    .text(val)
    .css({top: '-10px'})


