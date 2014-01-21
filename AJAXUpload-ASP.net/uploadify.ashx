﻿<%@ WebHandler Language="C#" Class="uploadify" %>

using System;
using System.Web;
using System.IO;

public class uploadify : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.Expires = -1;
        try
        {
            HttpPostedFile postedFile = context.Request.Files["Filedata"];

            string savepath = "";
            string tempPath = "";
            tempPath = context.Server.MapPath("TempFolder"); 
            savepath = context.Server.MapPath("Upload");
            string filename = postedFile.FileName; // System.IO.Path.GetFileName(postedFile.FileName);
            if (!Directory.Exists(savepath))
                Directory.CreateDirectory(savepath);

            postedFile.SaveAs(savepath + @"\" + filename);
            context.Response.Write(tempPath + "/" + filename);
            context.Response.StatusCode = 200;
        }
        catch (Exception ex)
        {
            context.Response.Write("Error: " + ex.Message);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}