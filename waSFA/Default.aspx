<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="waSFA._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%--<div class="jumbotron">--%>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4 col-xs-12">
                <asp:Image runat="server" ImageUrl="~/res/Logo.png" ID="logo" CssClass="center-block"/>
            </div>
            <div class="col-md-4"></div>
        </div>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4 col-xs-12">
                <input type="text" class="form-control center-block" id="usr" runat="server" placeholder="Usuario">
            </div>
            <div class="col-md-4"></div>
        </div>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4 col-xs-12">
                <input type="password" class="form-control center-block" id="pwd" runat="server" placeholder="Contraseña">
            </div>
            <div class="col-md-4"></div>
        </div>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4 col-xs-12">
                <asp:Button OnClick="Login" Text="Iniciar Sesion" type="submit" class="btn btn-primary center-block" runat="server" id="btnLogin"></asp:Button>
            </div>
            <div class="col-md-4"></div>
        </div>
    <%--</div>--%>

</asp:Content>
