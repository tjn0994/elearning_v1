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
    $counter_member = $('#notification-counter-member')
    val_member = parseInt $counter_member.text()
    val_member++
    $counter_member
    .text(val_member)
    .css({top: '-10px'})
