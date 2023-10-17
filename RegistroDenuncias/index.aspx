<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="RegistroDenuncias.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Formularios</title>
    <style>
        body {
           background: rgb(177,177,230);
           background: radial-gradient(circle, rgba(177,177,230,1) 0%, rgba(213,226,241,1) 100%);
           background-size:inherit;
        }
        form {
            display:flex;
            flex-direction:row;
        }
        h2 {
            margin-left:30px;
            font-family:'Cambria Math';
        }
        #container1 {
            background: radial-gradient(circle, rgba(174,238,228,1) 0%, rgba(148,187,233,1) 100%);
            width:450px;
            height:400px;
            margin: auto;
            border:solid 1px black;
        }
        #containerGrid {
            background: radial-gradient(circle, rgba(238,174,202,1) 0%, rgba(148,187,233,1) 100%);
            margin: auto;
            width: 300px;
            height: 400px;
            border: 1px solid blue;
        }
        #gv1 {
            margin:30px;
        }

        #container2 {
            background: radial-gradient(circle, rgba(180,177,230,1) 0%, rgba(213,226,241,1) 100%);
            margin: auto;
            right:0;
            width:400px;
            height:400px;
            border:solid 1px black;
        }
        #container1, #container2, #containerGrid {
            -webkit-box-shadow: 1px 10px 89px -10px rgba(0,0,0,0.53);
            -moz-box-shadow: 1px 10px 89px -10px rgba(0,0,0,0.53);
            box-shadow: 1px 10px 89px -10px rgba(0,0,0,0.53);
        }


        .inputClass {
            margin-bottom:20px;
            margin-left:30px;
        }
        #Label1, #Label2 {
            margin-left:30px;
            font-size:20px;
        }
        #ddlEliminarDenID, #ddlEliminarCategoriaID {
            margin-left:30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="container1">
            <h2>Formulario para Denuncias</h2>
            
            <asp:TextBox ID="txtDenuncia" CssClass="inputClass" runat="server" Placeholder="Texto de la denuncia"></asp:TextBox>
            <asp:DropDownList ValidateRequestMode="Enabled" ID="ddlCategoria" runat="server" DataTextField="nombre" DataValueField="denCat_id" DataSourceID="SqlDataSource2" AutoPostBack="True" ></asp:DropDownList>
            <asp:Button ID="btnGuardarDen" runat="server" Text="Guardar" OnClick="btnGuardarDen_Click" />
            

            <asp:TextBox ID="txtNuevoTexto" CssClass="inputClass" runat="server" Placeholder="Nuevo texto de la denuncia"></asp:TextBox>
            <asp:DropDownList ID="ddlActualizarDenID" runat="server" AutoPostBack="true" DataTextField="texto" DataValueField="den_id" DataSourceID="SqlDataSource1" Width="100px"></asp:DropDownList>
            <asp:Button ID="btnActualizarDen" runat="server" Text="Actualizar" OnClick="btnActualizarDen_Click" /><br />
            <asp:Label ID="Label1" runat="server" Text="Eliminar Denuncia"></asp:Label><br />
            <asp:DropDownList ID="ddlEliminarDenID" runat="server" AutoPostBack="true" DataTextField="texto" DataValueField="den_id" DataSourceID="SqlDataSource1" CssClass="inputClass"></asp:DropDownList>
            <asp:Button ID="btnEliminarDen" runat="server" Text="Eliminar" OnClick="btnEliminarDen_Click" />
            
            
        </div>
        <div id="containerGrid">
            <asp:GridView runat="server" AutoGenerateColumns="False" DataSourceID="SelectForGridV" ID="gv1">
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="Categoria"></asp:BoundField>
                    <asp:BoundField DataField="CantidadDeDenuncias" HeaderText="CantidadDeDenuncias" ></asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="SelectForGridV" ConnectionString="<%$ ConnectionStrings:Conexion %>" SelectCommand="SELECT DC.nombre, COUNT(D.den_id) AS CantidadDeDenuncias FROM Denuncias AS D INNER JOIN DenunciaCategorias AS DC ON D.idDenunciaCategoria = DC.denCat_id GROUP BY DC.nombre"></asp:SqlDataSource>         
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:Conexion %>" DeleteCommand="DELETE FROM [Denuncias] WHERE [den_id] = @den_id" InsertCommand="INSERT INTO [Denuncias] ([texto], [idDenunciaCategoria]) VALUES (@texto, @idDenunciaCategoria)" ProviderName="<%$ ConnectionStrings:Conexion.ProviderName %>" SelectCommand="SELECT * FROM denuncias" UpdateCommand="UPDATE Denuncias SET texto = @texto WHERE (den_id = @den_id)" >
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtDenuncia" PropertyName="Text" Name="texto" />
                    <asp:ControlParameter ControlID="ddlCategoria" PropertyName="SelectedValue" Name="idDenunciaCategoria" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtNuevoTexto" PropertyName="Text" Name="texto" />
                    <asp:ControlParameter ControlID="ddlActualizarDenID" PropertyName="SelectedValue" Name="den_id" /><%--Se puede sacar den_id para generar excepcion--%>
                </UpdateParameters>
                <DeleteParameters>
                    <asp:ControlParameter ControlID="ddlEliminarDenID" PropertyName="SelectedValue" Name="den_id" />
                </DeleteParameters>
            </asp:SqlDataSource>
            
        </div>

        <div id="container2">
            <h2>Formulario para Categorías</h2>
            <asp:TextBox ID="txtCategoria" CssClass="inputClass" runat="server" Placeholder="Nombre de la categoría"></asp:TextBox>
            <asp:Button ID="btnGuardarCategoria" runat="server" Text="Guardar" OnClick="btnGuardarCategoria_Click" />
            
            <asp:TextBox ID="txtNuevoNombreCategoria" CssClass="inputClass" runat="server" Placeholder="Nuevo nombre de la categoría"></asp:TextBox>
            <asp:DropDownList ID="ddlActualizarCategoriaID" runat="server" AutoPostBack="true" DataTextField="nombre" DataValueField="denCat_id" DataSourceID="SqlDataSource2"></asp:DropDownList>
            <asp:Button ID="btnActualizarCategoria" runat="server" Text="Actualizar" OnClick="btnActualizarCategoria_Click" /><br />
            <asp:Label ID="Label2" runat="server" Text="Eliminar categoria"></asp:Label><br />
            <asp:DropDownList ID="ddlEliminarCategoriaID" CssClass="inputClass" runat="server" AutoPostBack="true" DataTextField="nombre" DataValueField="denCat_id" DataSourceID="SqlDataSource2"></asp:DropDownList>
            <asp:Button ID="btnEliminarCategoria" runat="server" Text="Eliminar" OnClick="btnEliminarCategoria_Click" />
            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString="<%$ ConnectionStrings:Conexion %>" DeleteCommand="DELETE FROM [DenunciaCategorias] WHERE [denCat_id] = @denCat_id" InsertCommand="INSERT INTO [DenunciaCategorias] ([nombre]) VALUES (@nombre)" SelectCommand="SELECT * FROM [DenunciaCategorias]" UpdateCommand="UPDATE [DenunciaCategorias] SET [nombre] = @nombre WHERE [denCat_id] = @denCat_id">
                 <InsertParameters>
                     <asp:ControlParameter ControlID="txtCategoria" PropertyName="Text" Name="nombre" />
                 </InsertParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtNuevoNombreCategoria" PropertyName="Text" Name="nombre" />
                    <asp:ControlParameter ControlID="ddlActualizarCategoriaID" PropertyName="SelectedValue" Name="denCat_id" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:ControlParameter ControlID="ddlEliminarCategoriaID" PropertyName="SelectedValue" Name="denCat_id" />
                </DeleteParameters>
            </asp:SqlDataSource>
        </div>

    </form>
</body>
</html>
