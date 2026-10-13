using System;
using System.IO;
using System.Web;
using System.Xml.Linq;

namespace CanteenComplaintSystem
{
    /// <summary>
    /// Static logger class that records audit logs (Timestamp, Action, Details)
    /// directly into App_Data/ActivityLog.xml using XDocument.
    /// </summary>
    public static class XmlLogger
    {
        private static readonly object _fileLock = new object();

        private static string LogFilePath
        {
            get
            {
                string appDataPath = HttpContext.Current != null
                    ? HttpContext.Current.Server.MapPath("~/App_Data")
                    : Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "App_Data");

                if (!Directory.Exists(appDataPath))
                {
                    Directory.CreateDirectory(appDataPath);
                }

                return Path.Combine(appDataPath, "ActivityLog.xml");
            }
        }

        /// <summary>
        /// Record an audit log entry to App_Data/ActivityLog.xml.
        /// </summary>
        /// <param name="action">The name of the action executed.</param>
        /// <param name="details">Detailed description of the activity.</param>
        public static void LogAction(string action, string details)
        {
            LogActivity(action, details);
        }

        /// <summary>
        /// Appends a new LogEntry element into App_Data/ActivityLog.xml using XDocument.
        /// </summary>
        /// <param name="action">Action description.</param>
        /// <param name="details">Additional activity context.</param>
        public static void LogActivity(string action, string details)
        {
            lock (_fileLock)
            {
                try
                {
                    string filePath = LogFilePath;
                    XDocument doc;

                    if (File.Exists(filePath))
                    {
                        try
                        {
                            doc = XDocument.Load(filePath);
                        }
                        catch
                        {
                            // If XML file is corrupted or empty, create a new root document
                            doc = new XDocument(new XElement("ActivityLogs"));
                        }
                    }
                    else
                    {
                        doc = new XDocument(new XElement("ActivityLogs"));
                    }

                    if (doc.Root == null)
                    {
                        doc.Add(new XElement("ActivityLogs"));
                    }

                    XElement logEntry = new XElement("LogEntry",
                        new XElement("Timestamp", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")),
                        new XElement("Action", action ?? "UnknownAction"),
                        new XElement("Details", details ?? string.Empty)
                    );

                    doc.Root.Add(logEntry);
                    doc.Save(filePath);
                }
                catch (Exception ex)
                {
                    // Fail-safe diagnostic writing in case of concurrency or file access issues
                    System.Diagnostics.Debug.WriteLine("XmlLogger failed to record log: " + ex.Message);
                }
            }
        }
    }
}
