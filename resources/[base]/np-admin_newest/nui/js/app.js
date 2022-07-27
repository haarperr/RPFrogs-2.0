NP = {}
NPX.AdminMenu = {}
NPX.Coords = {}

NPX.AdminMenu.Action = {}
NPX.AdminMenu.Category = {}
NPX.AdminMenu.Sidebar = {}
NPX.AdminMenu.PlayerList = {}

NPX.AdminMenu.DebugEnabled = false
NPX.AdminMenu.Opened = false;
NPX.AdminMenu.IsGeneratingDropdown = false;

NPX.AdminMenu.Action.SelectedCat = null;
NPX.AdminMenu.Action.Selected = "All";
NPX.AdminMenu.Sidebar.Selected = "Actions";
NPX.AdminMenu.Sidebar.Size = "Small";

NPX.AdminMenu.FavoritedItems = {};
NPX.AdminMenu.PinnedTargets = {};
NPX.AdminMenu.EnabledItems = {};
NPX.AdminMenu.Settings = {};

NPX.AdminMenu.Players = null;
NPX.AdminMenu.Items = null;
NPX.AdminMenu.CurrentTarget = null;

NPX.AdminMenu.Update = function(Data) {
    DebugMessage(`Menu Updating`);
    NPX.AdminMenu.FavoritedItems = Data.Favorited;
    NPX.AdminMenu.PinnedTargets = Data.PinnedPlayers;
    NPX.AdminMenu.Settings = Data.MenuSettings;
    NPX.AdminMenu.Players = Data.AllPlayers
    NPX.AdminMenu.Items = Data.AdminItems
    NPX.AdminMenu.LoadItems();
}
 
NPX.AdminMenu.Open = function(Data) {
    DebugMessage(`Menu Opening`);
    NPX.AdminMenu.DebugEnabled = Data.Debug;
    NPX.AdminMenu.FavoritedItems = Data.Favorited;
    NPX.AdminMenu.PinnedTargets = Data.PinnedPlayers;
    NPX.AdminMenu.Settings = Data.MenuSettings;
    $('.menu-main-container').css('pointer-events', 'auto');
    $('.menu-main-container').fadeIn(450, function() {
        $('.menu-page-actions-search input').focus();
        if (NPX.AdminMenu.Items == null && NPX.AdminMenu.Players == null) {
            NPX.AdminMenu.Players = Data.AllPlayers
            NPX.AdminMenu.Items = Data.AdminItems
            if (NPX.AdminMenu.Sidebar.Selected == 'Actions') {
                $('.menu-pages').find(`[data-Page="${NPX.AdminMenu.Sidebar.Selected}"`).fadeIn(150);
                NPX.AdminMenu.LoadItems();
            }
        };
        NPX.AdminMenu.Players = Data.AllPlayers
        NPX.AdminMenu.Opened = true;
    });
}


NPX.AdminMenu.Close = function() {
    DebugMessage(`Menu Closing`);
    NPX.AdminMenu.ClearDropdown();
    $.post(`https://${GetParentResourceName()}/Admin/Close`);
    $('.menu-main-container').css('pointer-events', 'none');
    $('.menu-main-container').fadeOut(150, function() {
        NPX.AdminMenu.Opened = false; 
    });
}

NPX.AdminMenu.ChangeSize = function() {
    if (NPX.AdminMenu.Sidebar.Size == 'Small') {
        $('.menu-size-change').html('<i class="fas fa-chevron-right"></i>');
        NPX.AdminMenu.Sidebar.Size = 'Large';
        $('.menu-main-container').css({
            width: 50+"%",
            right: 25+"%",
        });
    } else {
        $('.menu-size-change').html('<i class="fas fa-chevron-left"></i>');
        NPX.AdminMenu.Sidebar.Size = 'Small';
        $('.menu-main-container').css({
            width: 24.24+"%",
            right: 3+"%",
        });
    }
}

NPX.Coords.Copy = function(Data) {
    let TextArea = document.createElement('textarea');
    let Selection = document.getSelection();
    TextArea.textContent = Data.Coords;
    document.body.appendChild(TextArea);
    Selection.removeAllRanges();
    TextArea.select();
    document.execCommand('copy');
    Selection.removeAllRanges();
    document.body.removeChild(TextArea);
}

// [ CLICKS ] \\

$(document).on('click', '.menu-size-change', function(e) {
    e.preventDefault();
    NPX.AdminMenu.ChangeSize()
});

$(document).on('click', '.menu-current-target', function(e){
    $(this).parent().find('.ui-styles-input').each(function(Elem, Obj){
        if ($(this).find('input').data("PlayerId")) {
            if (NPX.AdminMenu.CurrentTarget != null) {
                if ($('.admin-menu-item').find('.admin-menu-items-option-input').first().find('.ui-input-label').text() == 'Player') {
                    $(this).find('input').data("PlayerId", null)
                    $(this).find('input').val(" ");
                }
            }
        }
    });
    $('.admin-menu-items').animate({
        'max-height': 72.6+'vh',
    }, 100);
    $('.menu-current-target').fadeOut(150);
    NPX.AdminMenu.CurrentTarget = null;
});

// [ FUNCTIONS ] \\

DebugMessage = function(Message) {
    if (NPX.AdminMenu.DebugEnabled) {
        console.log(`[DEBUG]: ${Message}`);
    }
}

// [ LISTENER ] \\

document.addEventListener('DOMContentLoaded', (event) => {
    DebugMessage(`Menu Initialised`)
    NPX.AdminMenu.Action.SelectedCat = $('.menu-page-action-header-categories').find('.active');
    window.addEventListener('message', function(event){
        let Action = event.data.Action;
        let Data = event.data
        switch(Action) {
            case "Open":
                NPX.AdminMenu.Open(Data);
                break;
            case "Close":
                if (!NPX.AdminMenu.Opened) return;
                NPX.AdminMenu.Close();
                break;
            case "Update":
                if (!NPX.AdminMenu.Opened) return;
                NPX.AdminMenu.Update(Data);
                break;
            case "SetItemEnabled":
                NPX.AdminMenu.EnabledItems[Data.Name] = Data.State;
                Data.State ? $(`#admin-option-${Data.Name}`).addClass('enabled') : $(`#admin-option-${Data.Name}`).removeClass('enabled');
                break;
            case 'copyCoords':
                NPX.Coords.Copy(event.data);
                break;
        }
    });
});

$(document).on({
    keydown: function(e) {
        if (e.keyCode == 27 && NPX.AdminMenu.Opened) {
            NPX.AdminMenu.Close();
        }
    },
});