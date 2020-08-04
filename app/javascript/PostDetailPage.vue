<template>
  <div>
    <organization-chart :datasource="ds"></organization-chart>
  </div>
</template>

<script>
  import axios from 'axios';
  import OrganizationChart from 'vue-organization-chart'
  import 'vue-organization-chart/dist/orgchart.css'


  export default {
    components: {
      OrganizationChart
    },
    data () {
      return {
        ds: {
          'id': '1',
          'title': '幼女がいたらどうする？',
          'children': [
            { 'id': '2', 'title': '逃げる',
              'children': [
                { 'id': '11', 'title': 'なぜ？',
                  'children': [
                    {'id': '12', 'title': '無実の罪を着せられたくない' },
                    {'id': '13', 'title': '何かしてしまいそうだから',
                    'children': [
                      {'id': '20', 'title': '過去にそういう経験がある？',
                       'children': [
                         {'id': '21', 'title': 'ある'}
                       ]}
                    ]}
                  ]
                }
              ]
            },
            { 'id': '3', 'title': '匂いを嗅ぐ',
              'children': [
                { 'id': '14', 'title': 'なぜ？',
                  'children': [
                    {'id': "15", "title": "興奮するから",
                     'children':[
                        {'id': '17', 'title': 'どういう匂いが好き？',
                         'children': [
                           {'id': '18', 'title': '汗'},
                           {'id': '19', 'title': 'シャンプー'},
                           {'id': '26', 'title': 'おしっこ'}
                         ]}
                     ]
                   },
                   {'id': '16', 'title': '宗教上の理由',
                    'children': [
                      {'id': '23', 'title': '何教？',
                       'children': [
                         {'id': '24', 'title': 'キリスト教'},
                         {'id': '25', 'title': '仏教'}
                       ]}
                     ]},
                     {'id': '22', 'title': '分からない'}
                   ]
                }
              ]
            },
            {'id': '4', 'title': '何もしない'},
            {'id': '5', 'title': '抱きつく',
             'children': [
               {'id': '6', 'title': '何故抱きつく？',
                'children': [
                  {'id': '7', 'title': '逮捕してほしい'},
                  {'id': '8', 'title': '幼女が好きだから'},
                  {'id': '9', 'title': '何かにすがりたいから'},
                  {'id': '10', 'title': '特に理由はない'}
                ]}
              ]}
            ]
          }
        }
      },
    mounted () {
      axios
        .get(`/posts/${this.$route.params.id}.html`)
        .then(response => (this.node = response.data))
    }
  }
</script>
