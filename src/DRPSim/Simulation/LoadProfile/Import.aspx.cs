namespace DRPSim.Simulation.LoadProfile
{
    using System;
    using System.IO;
    using System.Web.UI;
    using Aspose.Cells;
    using Model;
    using Model.Simulation;
    using Rhino.Commons;

    public partial class Import : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            // open and read excel file
            var workbook = new Workbook();
            var fileType = FileFormatType.CSV;
            if(Path.GetExtension(ImportFile.FileName) == ".xlsx") fileType = FileFormatType.Excel2007Xlsx;
            else if(Path.GetExtension(ImportFile.FileName) == ".xls") fileType = FileFormatType.Excel2003;
            else if(Path.GetExtension(ImportFile.FileName) == ".csv") fileType = FileFormatType.CSV;
            else
            {
                ErrorMessage.Text = "Incorrect file type. We need an excel file!";
                return;
            }

            workbook.Open(ImportFile.FileContent, fileType);
            var sheet = workbook.Worksheets[0];

            var loadProfileRepository = IoC.Resolve<IRepository<Model.Simulation.LoadProfile>>();
            var userRepository = IoC.Resolve<IRepository<User>>();
            using (var tran = UnitOfWork.Current.BeginTransaction())
            {
                var loadProfile = new Model.Simulation.LoadProfile
                                      {
                                          Name = Name.Text,
                                          Description = Description.Text,
                                          AddedBy = userRepository.Load(new Guid(User.Identity.Name))
                                      };

                for (var row = 1; row <= sheet.Cells.MaxRow; row++ )
                {
                    loadProfile.Data.Add(new LoadProfileData
                                             {
                                                 StartTime =
                                                     DateTime.Parse(sheet.Cells[row, 0].StringValue + " " +
                                                                    sheet.Cells[row, 1].StringValue),
                                                 EndTime =
                                                     DateTime.Parse(sheet.Cells[row, 2].StringValue + " " +
                                                                    sheet.Cells[row, 3].StringValue),
                                                 Consumption = sheet.Cells[row, 4].DoubleValue
                                             });
                }


                loadProfileRepository.Save(loadProfile);

                tran.Commit();
                UnitOfWork.Current.TransactionalFlush();

                SuccessMessage.Text = "Load Profile imported successfully.";
            }

            ClearFields();
        }

        private void ClearFields()
        {
            Name.Text = "";
            Description.Text = "";
        }
    }
}