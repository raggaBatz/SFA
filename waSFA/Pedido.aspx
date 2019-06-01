<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pedido.aspx.cs" Inherits="waSFA.Pedido" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row form-inline" >
        <div class="col-md-1" >
            <label class="input-lg">Sucursal</label></div>
        <div class="col-md-5">
            <asp:DropDownList ID="ddlSucursal" runat="server" CssClass="form-control input-lg" OnSelectedIndexChanged="ddlSucursal_SelectedIndexChanged" AutoPostBack="true">
                
            </asp:DropDownList>
        </div>
        <div class="col-md-1" >
            <label class="input-lg">Cliente</label>
        </div>
        <div class="col-md-5" >
            <asp:DropDownList ID="ddlCliente" runat="server" CssClass="form-control input-lg">
                
            </asp:DropDownList>
        </div>
    </div>
    <hr />
    <div class="row">
        <div class="col-md-12 table-responsive">
            <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False" AllowPaging="true" PageSize="10" CssClass="table table-striped">
                <Columns>
                    <asp:BoundField DataField="ID_ARTICULO" HeaderText="ID" SortExpression="ID_ARTICULO" Visible="TRUE"/>
                    <asp:BoundField DataField="NOMBRE" HeaderText="PRODUCTO" SortExpression="NOMBRE"/>
                    <asp:BoundField DataField="PRECIO" HeaderText="PRECIO" SortExpression="PRECIO"/>
                    <asp:TemplateField HeaderText="CANTIDAD" SortExpression="CANTIDAD">
                        <ItemTemplate>
                            <asp:TextBox ID="tbxCantidad" runat="server" Text=""></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="sucess"/>
                <PagerStyle CssClass=""/>
            </asp:GridView>
        </div>
    </div>
    <div class="row form-inline" >
        <div class="col-xs-0 col-md-4" >
        </div>
        <div class="col-xs-4 col-md-4" >
            <asp:Button ID="btnSave" runat="server" Text="Generar" OnClick="btnSave_Click" CssClass="btn btn-success btn-lg" />
        </div>
        <div class="col-xs-1 col-sm-0" >
        </div>
        <div class="col-xs-4 col-md-4" >
            <asp:Button ID="btnClear" runat="server" Text="Cancelar" OnClick="btnClear_Click" CssClass="btn btn-danger btn-lg" />
        </div>
        <div class="col-xs-4 col-md-4" >
        </div>
    </div>
</asp:Content>
