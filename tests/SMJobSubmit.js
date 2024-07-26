// SMJobSubmit(CFStringRef domain, CFDictionaryRef job, AuthorizationRef auth, CFErrorRef _Nullable *error)
Interceptor.attach(Module.getExportByName('/System/Library/PrivateFrameworks/ServiceManagement.framework/ServiceManagement', 'SMJobSubmit'), {
    onEnter: function (args) {
       try {
            var domain = new ObjC.Object(args[0]); // CFStringRef
            var job = new ObjC.Object(args[1]); // CFDictionaryRef
            var auth = args[2]; // AuthorizationRef (pointer, we might not need to convert it)
            var error = args[3]; // CFErrorRef * (pointer to pointer)

            console.log('domain:', domain.toString());
            console.log('job:', job.toString());
            console.log('auth:', auth.toString());
            console.log('error:', error.toString());

        } catch (e) {
            console.error('Error processing arguments:', e);
        }
    }
});
