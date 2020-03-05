# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Source.create([
    {
        name: 'VnExpress',
        url:  'https://vnexpress.net/',
        logo: 'https://s.vnecdn.net/vnexpress/restruct/i/v94/graphics/img_logo_vne_web.svg',
        icon: 'https://s.vnecdn.net/vnexpress/restruct/i/v94/logos/57x57.png'
    },
    {
        name: 'Thanh Niên',
        url:  'https://thanhnien.vn/',
        logo: 'https://static.thanhnien.vn/v3/App_Themes/img/TNO_slogo.svg',
        icon: 'https://thanhnien.vn/favicon.ico?1'
    },
    {
        name: 'Người Lao Động',
        url:  'https://nld.com.vn/',
        logo: '',
        icon: 'https://static.mediacdn.vn/nld/web_images/nld57.png'
    },
    {
        name: 'Vietnamnet',
        url:  'https://vietnamnet.vn/',
        logo: 'https://vnn-res.vgcloud.vn/ResV9/images/logo-vnn-hungcuong-d2.svg',
        icon: 'https://vnn-res.vgcloud.vn/ResV9/images/faviconvnn2018.ico'
    }
])