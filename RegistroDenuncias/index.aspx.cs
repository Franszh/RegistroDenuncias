using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RegistroDenuncias
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }


        //----------Metodo para guardar las excepciones-------------------//

        protected void SaveExcep(String message) {
            StreamWriter streamWriter = new StreamWriter($"{Server.MapPath(".")}/Excepciones.txt", true);

            streamWriter.WriteLine($"{message} \n");
            streamWriter.Close();
        }


        //--------------------------------------------------------------//

      

        protected void btnGuardarDen_Click(object sender, EventArgs e)
        {

            if (txtDenuncia.Text != String.Empty) {


                try
                {
                    SqlDataSource1.Insert();
                    txtDenuncia.Text = String.Empty;
                    gv1.DataBind();
                }
                catch (Exception message)
                {

                    ClientScript.RegisterStartupScript(this.GetType(), "alertScript", "alert('Error al insertar');", true);
                    SaveExcep(message.ToString());
                }
            }else ClientScript.RegisterStartupScript(this.GetType(), "alertScript", "alert('Rellenar texto de denuncia');", true);

        }


        protected void btnActualizarDen_Click(object sender, EventArgs e)
        {
            if (txtNuevoTexto.Text != String.Empty)
            {


                try
                {
                    SqlDataSource1.Update();
                    txtNuevoTexto.Text = String.Empty;
                    gv1.DataBind();
                }
                catch (Exception message)
                {
                    
                    ClientScript.RegisterStartupScript(this.GetType(), "alertScript", "alert('Error al actualizar');", true);
                    SaveExcep(message.ToString());
                }
            }
            else ClientScript.RegisterStartupScript(this.GetType(), "alertScript", "alert('Rellenar texto para actualizar denuncia');", true);
        }

        protected void btnEliminarDen_Click(object sender, EventArgs e)
        {


             try
             {
                 SqlDataSource1.Delete();
                 txtNuevoNombreCategoria.Text = String.Empty;
                 gv1.DataBind();
             }
             catch (Exception message)
             {
                 ClientScript.RegisterStartupScript(this.GetType(), "alertScript", "alert('Error al eliminar');", true);
                 SaveExcep(message.ToString());
             }

           

        }

        protected void btnGuardarCategoria_Click(object sender, EventArgs e)
        {
            if (txtCategoria.Text != String.Empty)
            {


                try
                {
                    SqlDataSource2.Insert();
                    txtCategoria.Text = String.Empty;
                    gv1.DataBind();
                }
                catch (Exception message)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alertScript", "alert('Error al guardar');", true);
                    SaveExcep(message.ToString());
                }
            }
            else ClientScript.RegisterStartupScript(this.GetType(), "alertScript", "alert('Rellenar nombre de categoria');", true);
        }

        protected void btnActualizarCategoria_Click(object sender, EventArgs e)
        {
            if (txtNuevoNombreCategoria.Text != String.Empty)
            {


                try
                {
                    SqlDataSource2.Update();
                    txtNuevoNombreCategoria.Text = String.Empty;
                    gv1.DataBind();
                }
                catch (Exception message)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alertScript", "alert('Error al actualizar');", true);
                    SaveExcep(message.ToString());
                }

            }
            else ClientScript.RegisterStartupScript(this.GetType(), "alertScript", "alert('Rellenar texto para actualizar categoria');", true);
        }

        protected void btnEliminarCategoria_Click(object sender, EventArgs e)
        {
            try
            {
                SqlDataSource2.Delete();
                gv1.DataBind();
            }
            catch (Exception message)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alertScript", "alert('Error al eliminar');", true);
                SaveExcep(message.ToString());
            }

        }

      

        
    }
}