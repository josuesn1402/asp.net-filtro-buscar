<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Semana10E01.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title></title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.0/css/bulma.min.css" />
</head>

<body>
  <form id="form1" runat="server" class="section">
    <div class="container">
      <h2 class="title">Buscardor</h2>
      <div class="field is-group">
        <div class="control">
          <asp:TextBox ID="txtTerminoBusqueda" runat="server" CssClass="input"
            placeholder="Ingrese termino de búsqueda"></asp:TextBox>
        </div>
        <br />
        <div class="control">
          <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="button is-primary" OnClick="btnBuscar_Click" />
          <asp:Button ID="btnBuscarId" runat="server" Text="Buscar por ID" CssClass="button is-primary" OnClick="btnBuscarId_Click" />
        </div>
      </div>
      <br />
      <div>
        <asp:Label ID="lblNoResult" runat="server" Text="No se a encontrarón resultados"
          Visible="false" CssClass="message"></asp:Label>
      </div>
      <div class="tabla-container">
        <asp:GridView ID="gvResult" runat="server"
          AutoGenerateColumns="true"
          CssClass="table is-hoverable is-fullwidth"
          AllowPaging="true"
          OnSelectedIndexChanged="gvResult_SelectedIndexChanged"
          OnPageIndexChanging="gvResult_PageIndexChanging">
        </asp:GridView>
      </div>
    </div>
  </form>
</body>
</html>
