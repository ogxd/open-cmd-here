using System.Runtime.InteropServices;
using System.Windows.Forms;
using SharpShell.Attributes;
using SharpShell.SharpContextMenu;
using System.Diagnostics;
using System.IO;
using System.Drawing;
using OpenCmdHere.Properties;

namespace OpenCmdHere {

    [ComVisible(true)]
    [COMServerAssociation(AssociationType.Class, @"Directory\Background")]
    public class ContextMenu : SharpContextMenu {

        protected override bool CanShowMenu() {
            return true;
        }

        protected override ContextMenuStrip CreateMenu() {

            var contextMenu = new ContextMenuStrip();

            var menuItem = new ToolStripMenuItem("Open Cmd Here", GetBitmap());
            menuItem.Click += (sender, args) => openCmdHere();
            contextMenu.Items.Add(menuItem);

            return contextMenu;
        }

        private void openCmdHere() {
            var pinfo = new ProcessStartInfo();
            pinfo.UseShellExecute = true;
            pinfo.WorkingDirectory = FolderPath;
            pinfo.FileName = "cmd.exe";
            Process process = Process.Start(pinfo);
        }

        public static Bitmap GetBitmap() {
            if (Extensions.Dpi > 0.96f * 250 - 1) {
                return (Bitmap)Resources.ResourceManager.GetObject("Console40", Resources.Culture);
            }
            if (Extensions.Dpi > 0.96f * 225 - 1) {
                return (Bitmap)Resources.ResourceManager.GetObject("Console36", Resources.Culture);
            }
            if (Extensions.Dpi > 0.96f * 200 - 1) {
                return (Bitmap)Resources.ResourceManager.GetObject("Console32", Resources.Culture);
            }
            if (Extensions.Dpi > 0.96f * 175 - 1) {
                return (Bitmap)Resources.ResourceManager.GetObject("Console28", Resources.Culture);
            }
            if (Extensions.Dpi > 0.96f * 150 - 1) {
                return (Bitmap)Resources.ResourceManager.GetObject("Console24", Resources.Culture);
            }
            if (Extensions.Dpi > 0.96f * 125 - 1) {
                return (Bitmap)Resources.ResourceManager.GetObject("Console20", Resources.Culture);
            }
            return (Bitmap)Resources.ResourceManager.GetObject("Console16", Resources.Culture);
        }
    }
}