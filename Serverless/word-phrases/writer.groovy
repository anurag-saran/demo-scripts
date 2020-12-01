from('timer:messages?period=10000')
  .setBody().constant('the-body')
  .to('knative:endpoint/reader')
