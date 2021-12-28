<%@ Page Title="Mis Recetas" Language="C#" MasterPageFile="~/templates/base/baseChefcito.Master" AutoEventWireup="true" CodeBehind="recetas.aspx.cs"  %>

<%@ Register Src="~/templates/WebUserControl1.ascx" TagPrefix="uc1" TagName="WebUserControl1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
    <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="receta_id">
        <AlternatingItemTemplate>
            <tr style="background-color: #FFFFFF;color: #284775;">
                <td>
                    <asp:Label ID="receta_idLabel" runat="server" Text='<%# Eval("receta_id") %>' />
                </td>
                <td>
                    <asp:Label ID="receta_nombreLabel" runat="server" Text='<%# Eval("receta_nombre") %>' />
                </td>
                <td>
                    <asp:Label ID="receta_categoriaLabel" runat="server" Text='<%# Eval("receta_categoria") %>' />
                </td>
                <td>
                    <asp:Label ID="receta_descripcionLabel" runat="server" Text='<%# Eval("receta_descripcion") %>' />
                </td>
                <td>
                    <asp:Label ID="receta_fotoLabel" runat="server" Text='<%# Eval("receta_foto") %>' />
                    <img src="../assets/img/avatar.png" alt="img receta" />
                </td>
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <tr style="background-color: #999999;">
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" />
                </td>
                <td>
                    <asp:Label ID="receta_idLabel1" runat="server" Text='<%# Eval("receta_id") %>' />
                </td>
                <td>
                    <asp:TextBox ID="receta_nombreTextBox" runat="server" Text='<%# Bind("receta_nombre") %>' />
                </td>
                <td>
                    <asp:TextBox ID="receta_categoriaTextBox" runat="server" Text='<%# Bind("receta_categoria") %>' />
                </td>
                <td>
                    <asp:TextBox ID="receta_descripcionTextBox" runat="server" Text='<%# Bind("receta_descripcion") %>' />
                </td>
                <td>
                    <asp:TextBox ID="receta_fotoTextBox" runat="server" Text='<%# Bind("receta_foto") %>' />
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>No se han devuelto datos.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insertar" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Borrar" />
                </td>
                <td>
                    <asp:TextBox ID="receta_idTextBox" runat="server" Text='<%# Bind("receta_id") %>' />
                </td>
                <td>
                    <asp:TextBox ID="receta_nombreTextBox" runat="server" Text='<%# Bind("receta_nombre") %>' />
                </td>
                <td>
                    <asp:TextBox ID="receta_categoriaTextBox" runat="server" Text='<%# Bind("receta_categoria") %>' />
                </td>
                <td>
                    <asp:TextBox ID="receta_descripcionTextBox" runat="server" Text='<%# Bind("receta_descripcion") %>' />
                </td>
                <td>
                    <asp:TextBox ID="receta_fotoTextBox" runat="server" Text='<%# Bind("receta_foto") %>' />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="background-color: #E0FFFF;color: #333333;">
                <td>
                    <asp:Label ID="receta_idLabel" runat="server" Text='<%# Eval("receta_id") %>' />
                </td>
                <td>
                    <asp:Label ID="receta_nombreLabel" runat="server" Text='<%# Eval("receta_nombre") %>' />
                </td>
                <td>
                    <asp:Label ID="receta_categoriaLabel" runat="server" Text='<%# Eval("receta_categoria") %>' />
                </td>
                <td>
                    <asp:Label ID="receta_descripcionLabel" runat="server" Text='<%# Eval("receta_descripcion") %>' />
                </td>
                <td>
                    <img src="../assets/img/avatar.png" alt="img receta" />
                    <asp:Label ID="receta_fotoLabel" runat="server" Text='<%# Eval("receta_foto") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr runat="server" style="background-color: #E0FFFF;color: #333333;">
                                <th runat="server">ID</th>
                                <th runat="server">Nombre de la Receta</th>
                                <th runat="server">Categoria</th>
                                <th runat="server">Descripcion</th>
                                <th runat="server">Foto</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="text-align: center;background-color: #5D7B9D;font-family: Verdana, Arial, Helvetica, sans-serif;color: #FFFFFF"></td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="background-color: #E2DED6;font-weight: bold;color: #333333;">
                <td>
                    <asp:Label ID="receta_idLabel" runat="server" Text='<%# Eval("receta_id") %>' />
                </td>
                <td>
                    <asp:Label ID="receta_nombreLabel" runat="server" Text='<%# Eval("receta_nombre") %>' />
                </td>
                <td>
                    <asp:Label ID="receta_categoriaLabel" runat="server" Text='<%# Eval("receta_categoria") %>' />
                </td>
                <td>
                    <asp:Label ID="receta_descripcionLabel" runat="server" Text='<%# Eval("receta_descripcion") %>' />
                </td>
                <td>
                    <asp:Label ID="receta_fotoLabel" runat="server" Text='<%# Eval("receta_foto") %>' />
                </td>
            </tr>
        </SelectedItemTemplate>
        </asp:ListView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Recetas]"></asp:SqlDataSource>
</form>
    <uc1:WebUserControl1 runat="server" id="WebUserControl1" />
</asp:Content>

