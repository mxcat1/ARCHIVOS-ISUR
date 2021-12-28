<%@ Page Title="Categorias" Language="C#" MasterPageFile="~/templates/base/baseChefcito.Master" AutoEventWireup="true" CodeBehind="categorias.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="categoria_id" DataSourceID="SqlDataSource1">
        <AlternatingItemTemplate>
            <tr style="background-color:#FFF8DC;">
                <td>
                    <asp:Label ID="categoria_idLabel" runat="server" Text='<%# Eval("categoria_id") %>' />
                </td>
                <td>
                    <asp:Label ID="nombre_categoriaLabel" runat="server" Text='<%# Eval("nombre_categoria") %>' />
                </td>
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <tr style="background-color:#008A8C;color: #FFFFFF;">
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Actualizar" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancelar" />
                </td>
                <td>
                    <asp:Label ID="categoria_idLabel1" runat="server" Text='<%# Eval("categoria_id") %>' />
                </td>
                <td>
                    <asp:TextBox ID="nombre_categoriaTextBox" runat="server" Text='<%# Bind("nombre_categoria") %>' />
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
                    <asp:TextBox ID="categoria_idTextBox" runat="server" Text='<%# Bind("categoria_id") %>' />
                </td>
                <td>
                    <asp:TextBox ID="nombre_categoriaTextBox" runat="server" Text='<%# Bind("nombre_categoria") %>' />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="background-color:#DCDCDC;color: #000000;">
                <td>
                    <asp:Label ID="categoria_idLabel" runat="server" Text='<%# Eval("categoria_id") %>' />
                </td>
                <td>
                    <asp:Label ID="nombre_categoriaLabel" runat="server" Text='<%# Eval("nombre_categoria") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr runat="server" style="background-color:#DCDCDC;color: #000000;">
                                <th runat="server">ID</th>
                                <th runat="server">Nombre Categoria</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;"></td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="background-color:#008A8C;font-weight: bold;color: #FFFFFF;">
                <td>
                    <asp:Label ID="categoria_idLabel" runat="server" Text='<%# Eval("categoria_id") %>' />
                </td>
                <td>
                    <asp:Label ID="nombre_categoriaLabel" runat="server" Text='<%# Eval("nombre_categoria") %>' />
                </td>
            </tr>
        </SelectedItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Categorias]"></asp:SqlDataSource>
    </form>
</asp:Content>

