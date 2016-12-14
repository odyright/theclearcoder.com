defmodule Blog.BrandingControllerTest do
  use Blog.ConnCase, async: true

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

    test "'index' lists all branding", %{conn: conn} do
      brand = Fixtures.create(:branding)
      conn = get conn, branding_path(conn, :index)
      assert html_response(conn, 200) =~ ~r/Branding/
      assert String.contains?(conn.resp_body, brand.item)
    end

    test "'show' renders the branding if found", %{conn: conn} do
      brand = Fixtures.create(:branding)
      conn = get conn, branding_path(conn, :show, brand.id)
      assert html_response(conn, 200) =~ ~r/Showing Branding/
      assert String.contains?(conn.resp_body, brand.item)
    end

    test "'new' displays the new branding form", %{conn: conn} do
      conn = get conn, branding_path(conn, :new)
      assert html_response(conn, 200) =~ ~r/New Branding/
      assert String.contains?(conn.resp_body, "form")
    end

    test "'create' redirects to the index page after creation", %{conn: conn} do
      conn = post conn, branding_path(conn, :create, %{"branding" => new_branding()})
      assert html_response(conn, 302)
      assert conn.request_path == branding_path(conn, :index) 
    end

    test "'create' saves the new branding in the database", %{conn: conn} do
      branding = new_branding()
      post conn, branding_path(conn, :create, %{"branding" => branding})
      saved_branding = Repo.get_by(Blog.Branding, item: branding["item"])
      assert branding["item"] == saved_branding.item
    end

    test "'edit' displays an branding edit form", %{conn: conn} do
      branding = Fixtures.create(:branding)
      conn = get(conn, branding_path(conn, :edit, branding.id))
      assert html_response(conn, 200) =~ ~r/Edit Branding/
      assert String.contains?(conn.resp_body, branding.item)
    end

    test "'update' modifies existing branding in the database", %{conn: conn} do
      branding = Fixtures.create(:branding)
      put conn, branding_path(conn, :update, branding.id, 
                              %{"branding" => %{"item" => branding.item, "copy" => "new copy"}})
      updated_branding = Repo.get(Blog.Branding, branding.id)
      assert updated_branding.item == branding.item
      assert updated_branding.copy == "new copy"
    end

    test "'delete' removes branding from the database", %{conn: conn} do
      branding = Fixtures.create(:branding)
      delete conn, branding_path(conn, :delete, branding.id)
      assert Repo.get(Blog.Branding, branding.id) == nil
    end
  end

  defp login_test_user(context) do
    user = Fixtures.create(:user)
    conn = assign(context[:conn], :current_user, user)
    [conn: conn, user: user]
  end

  defp new_branding() do
    %{"item" => "TheBrand", "copy" => "The is some cool test branding."}
  end
end
