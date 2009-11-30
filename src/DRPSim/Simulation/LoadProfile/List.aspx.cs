namespace DRPSim.Simulation.LoadProfile
{
    using System;
    using System.IO;
    using System.Linq;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using Aspose.Cells;
    using Model;
    using Rhino.Commons;

    public partial class List : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;

            PopulateLoadProfilesGrid();
        }

        private void PopulateLoadProfilesGrid()
        {
            using (var tran = UnitOfWork.Current.BeginTransaction())
            {
                LoadProfilesGrid.DataBind();
                tran.Commit();
            }
        }

        protected void LoadProfilesGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                var loadProfileId = new Guid(e.CommandArgument.ToString());
                Response.Redirect("Edit.aspx?id=" + loadProfileId);
            }
            else if (e.CommandName == "Export")
            {
                var loadProfileRepository = IoC.Resolve<IRepository<Model.Simulation.LoadProfile>>();
                var loadProfile = loadProfileRepository.Get(new Guid(e.CommandArgument.ToString()));
                var workbook  = new Workbook();
                var sheet = workbook.Worksheets[0];
                sheet.Cells.Merge(0, 0, 1, 5);
                sheet.Cells[0, 0].PutValue(loadProfile.Name + " - " + loadProfile.Description);
                sheet.Cells[1, 0].PutValue("Start Date");
                sheet.Cells[1, 1].PutValue("Start Time");
                sheet.Cells[1, 2].PutValue("End Date");
                sheet.Cells[1, 3].PutValue("End Time");
                sheet.Cells[1, 4].PutValue("Consumption (kwh)");

                int rowIndex = 2;
                foreach (var data in loadProfile.Data)
                {
                    sheet.Cells[rowIndex, 0].PutValue(data.StartTime.ToShortDateString());
                    sheet.Cells[rowIndex, 1].PutValue(data.StartTime.ToShortTimeString());
                    sheet.Cells[rowIndex, 2].PutValue(data.EndTime.ToShortDateString());
                    sheet.Cells[rowIndex, 3].PutValue(data.EndTime.ToShortTimeString());
                    sheet.Cells[rowIndex, 4].PutValue(data.Consumption);
                    rowIndex++;
                }

                var outputFile = workbook.SaveToStream();
                Response.AppendHeader("Content-Disposition", "attachment;filename=" + loadProfile.Name + ".xls");
                Response.AppendHeader("Content-Length", outputFile.Length.ToString());
                Response.ContentType = "application/ms-excel";
                outputFile.WriteTo(Response.OutputStream);
            }
            else if (e.CommandName == "DeleteLoadProfile")
            {
                var loadProfileId = new Guid(e.CommandArgument.ToString());

                using (var tran = UnitOfWork.Current.BeginTransaction())
                {
                    var loadProfileRepository = IoC.Resolve<IRepository<Model.Simulation.LoadProfile>>();

                    var loadProfile = loadProfileRepository.Load(loadProfileId);
                    loadProfileRepository.Delete(loadProfile);

                    tran.Commit();
                    UnitOfWork.Current.TransactionalFlush();

                    SuccessMessage.Text = loadProfile.Name + " deleted successfully.";
                }

                PopulateLoadProfilesGrid();
            }
        }

        protected void LoadProfilesGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                
            }
        }

        protected void LoadProfilesGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            LoadProfilesGrid.PageIndex = e.NewPageIndex;
            PopulateLoadProfilesGrid();
        }
    }
}