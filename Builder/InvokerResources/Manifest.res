        ��  ��                  �      �� ��     0        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!-- Copyright (c) Microsoft Corporation -->
<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">

  <assemblyIdentity version="1.0.0.0"
     processorArchitecture="x86"
     name="TranslateGames.Updater"
     type="win32"/>
  
  <description>Translate Games Updater</description>

  <dependency>
    <dependentAssembly>
      <assemblyIdentity
          type="win32"
          name="Microsoft.Windows.Common-Controls"
          version="6.0.0.0"
          processorArchitecture="x86"
          publicKeyToken="6595b64144ccf1df"
          language="*"
       />
    </dependentAssembly>
  </dependency>

  <trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
    <security>
      <requestedPrivileges>
        <requestedExecutionLevel
          level="AsInvoker"
          uiAccess="false"/>
      </requestedPrivileges>
    </security>
  </trustInfo>
    <compatibility xmlns="urn:schemas-microsoft-com:compatibility.v1"> 
        <application> 
            <!--This Id value indicates the application supports Windows Vista/Server 2008 functionality -->
            <supportedOS Id="{e2011457-1546-43c5-a5fe-008deee3d3f0}"/> 
            <!--This Id value indicates the application supports Windows 7/Server 2008 R2 functionality-->
            <supportedOS Id="{35138b9a-5d96-4fbd-8e2d-a2440225f93a}"/>
            <!--This Id value indicates the application supports Windows 8/Server 2012 functionality-->
            <supportedOS Id="{4a2f28e3-53b9-4441-ba9c-d69d4a4a6e38}"/>
    	<!-- This Id value indicates the application supports Windows Blue/Server 2012 R2 functionality-->            
    	<supportedOS Id="{1f676c76-80e1-4239-95bb-83d0f6d0da78}"/>
    	<!-- This Id value indicates the application supports Windows 10 functionality-->            
    	<supportedOS Id="{8e0f7a12-bfb3-4fe8-b9a5-48fd50a15a9a}"/>
        </application> 
    </compatibility>
</assembly>