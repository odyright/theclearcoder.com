defmodule Blog.Web.BrandingControllerTest do
  use Blog.Web.ConnCase, async: true
  alias Blog.{Repo, Marketing.Branding}

  describe "with guest access" do
    test "login is required for all actions", %{conn: conn} do
      Enum.each [
        get(conn, branding_path(conn, :new)),
        get(conn, branding_path(conn, :index)),
        get(conn, branding_path(conn, :show, "1")),
        get(conn, branding_path(conn, :create, %{})),
        get(conn, branding_path(conn, :edit, "1")),
        put(conn, branding_path(conn, :update, "1", %{})),
        delete(conn, branding_path(conn, :delete, "1"))
      ], fn conn ->
        assert html_response(conn, 302)
        assert conn.halted
      end
    end
  end

  describe "with a logged in user" do
    setup :login_test_user

    test "should get the index", %{conn: conn} do
      brand    = Forge.saved_branding
      conn     = get conn, branding_path(conn, :index)
      response = html_response(conn, 200) 

      assert response =~ "Branding"
      assert response =~ brand.item
    end

    test "should show the branding", %{conn: conn} do
      brand    = Forge.saved_branding
      conn     = get conn, branding_path(conn, :show, brand.id)
      response = html_response(conn, 200) 

      assert response =~ "Showing Branding"
      assert response =~ brand.item
    end

    test "displays the new branding form with the new action", %{conn: conn} do
      conn     = get conn, branding_path(conn, :new)
      response = html_response(conn, 200)

      assert response =~ "New Branding"
      assert response =~ "form"
    end

    test "successful create redirects and sets a flash message", %{conn: conn} do
      conn = post conn, branding_path(conn, :create, %{"branding" => new_branding()})

      assert response(conn, 302) =~ branding_path(conn, :index) 
      assert get_flash(conn, :info) == "TheBrand created!"
    end

    test "failed create will display an error message", %{conn: conn} do
      branding = Map.delete(new_branding(), "copy")
      conn = post conn, branding_path(conn, :create, %{"branding" => branding})

      assert html_response(conn, 200) =~ "check the errors below"
    end

    test "displays an edit branding form with the edit action", %{conn: conn} do
      branding = Forge.saved_branding
      conn     = get(conn, branding_path(conn, :edit, branding.id))
      response = html_response(conn, 200)

      assert response =~ "Edit Branding"
      assert response =~ branding.item
    end

    test "successful update redirects and sets a flash message", %{conn: conn} do
      branding = Forge.saved_branding
      conn = put conn, branding_path(conn, :update, branding.id, 
                                     %{"branding" => %{"item" => branding.item, "copy" => "new copy"}})
      
      assert response(conn, 302) =~ branding_path(conn, :show, branding.id) 
      assert get_flash(conn, :info) =~ "Branding updated successfully"
    end

    test "failed update will display an error message", %{conn: conn} do
      branding = Forge.saved_branding
      conn = put conn, branding_path(conn, :update, branding.id, 
                                     %{"branding" => %{"item" => "foo", "copy" => " "}})

      assert html_response(conn, 200) =~ "check the errors below"
    end

    test "delete removes the branding from the database", %{conn: conn} do
      branding = Forge.saved_branding
      delete conn, branding_path(conn, :delete, branding.id)

      assert Repo.get(Branding, branding.id) == nil
    end
  end

  defp new_branding() do
    %{"item" => "TheBrand", "copy" => "The is some cool test branding."}
  end
end
