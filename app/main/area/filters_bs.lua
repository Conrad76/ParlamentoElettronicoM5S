slot.set_layout("m5s_bs")

local area = Area:by_id(param.get_id())
local gui_preset=db:query('SELECT gui_preset FROM system_setting')[1][1] or 'default'

if not area then
  slot.put_into("error", "Please provide a valid area id")
  return false
end

app.html_title.title = area.name
app.html_title.subtitle = _("Area")

util.help("area.show")

local unit_name
for i,v in pairs(config.gui_preset[gui_preset].units) do
  if config.gui_preset[gui_preset].units[i].unit_id == area.unit_id then unit_name = i end
end
 
if not config.gui_preset[gui_preset].units[unit_name] then
  slot.put_into("error", "unit_id for selected area is not configured in config.gui_preset")
  return false
end

slot.put("<br/>")

ui.container{ attr = { class  = "row-fluid" }, content = function()
  ui.container{ attr = { class  = "span12 well" }, content = function()
    ui.container{ attr = { class  = "row-fluid text-center" }, content = function()
      ui.tag { tag = "h4", attr = {class = "span12"},  content = _(config.gui_preset[gui_preset].units[unit_name].assembly_title, {realname = app.session.member.realname}) }
    end }
    ui.container{ attr = { class  = "row-fluid text-center" }, content = function()
      ui.tag { tag = "h3",attr = {class = "span12"}, content = _(config.gui_preset[gui_preset].units[unit_name].area_filter_title) }
    end }
    ui.container{ attr = { class  = "row-fluid" }, content = function()
      ui.link {
        attr = { class="btn btn-primary btn-large span3" },
        module = "unit",
        view = "show_ext",
        id = area.unit_id,
        content = function()
          ui.tag{ tag ="i" , attr = { class = "iconic black arrow-left" }, content=""}
          slot.put("&nbsp;".._"BACK TO PREVIOUS PAGE")
        end
      }
      if unit_name == "cittadini" or unit_name == "iscritti" then
        ui.link {
          attr = { class="btn btn-primary btn-large span3" },
          module = "area",
          view = "show_ext",
          params = { state = "admission"},
          id = area.id,
          content = _"INITIATIVES LOOKING FOR SUPPORTERS"
        }
      end
      ui.link {
        attr = { class="btn btn-primary btn-large span3" },
        module = "area",
        view = "show_ext",
        params = { state = "development"},
        id = area.id,
        content = _"INITIATIVES NOW IN DISCUSSION"
      }
      ui.link {
        attr = { class="btn btn-primary btn-large span3" },
        module = "area",
        view = "show_ext",
        params = { state = "closed"},
        id = area.id,
        content = _"COMPLETED OR RETIRED INITIATIVES"
      }
     end
    }
  
  end }
end }