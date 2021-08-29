describe SearchController do
  describe '.call' do
    describe "when I select a user" do
      let(:input) { double(:input, model_type: :users, field: :alias, query: 'Mr Ola') }

      it "returns a list of matching users with associated records" do
        actual = described_class.call(input)

        expect(actual.size).to eq(1)
        expect(actual.first.size).to eq(22)
        # NOTE: Using index might be temperamental (haven't experienced yet), also decrease maintainability
        expect(actual.first[4]).to match(/^name\s+Loraine Pittman$/i)
        expect(actual.first[17]).to match(/^tags\s+Delco; Forestburg; Frizzleburg; Sandston$/)
        expect(actual.first[20]).to match(/^organization_name\s+Enthaze$/)
        expect(actual.first[21])
          .to match(/^assigned_ticket_subjects\s+A Drama in Botswana; A Drama in Cameroon; A Drama in Gabon; A Drama in Saudi Arabia$/)
      end
    end

    describe "when I select a ticket" do
      let(:input) { double(:input, model_type: :tickets, field: :assignee_id, query: '11') }

      it "returns a list of matching tickets with associated records" do
        actual = described_class.call(input)

        expect(actual.size).to eq(1)
        expect(actual.first.size).to eq(19)
        expect(actual.first[6]).to match(/^subject\s+A Nuisance in Saint Lucia$/i)
        expect(actual.first[17]).to match(/^organization_name\s+Qualitern$/)
        expect(actual.first[18]).to match(/^assignee_name\s+Shelly Clements$/)
      end
    end

    describe "when I select an organization" do
      let(:input) { double(:input, model_type: :organizations, field: :_id, query: '103') }

      it "returns a list of matching organizations with associated records" do
        actual = described_class.call(input)

        expect(actual.size).to eq(1)
        expect(actual.first.size).to eq(10)
        expect(actual.first[4]).to match(/^name\s+Plasmos$/i)
        expect(actual.first[5]).to match(/^domain_names\s+automon.com; comvex.com; gogol.com; verbus.com$/)
        expect(actual.first[9]).to match(/^tags\s+Armstrong; Lindsay; Parrish; Vaughn$/)
      end

      it "returns multiple organizations" do
        input = double(:input, model_type: :users, field: :organization_id, query: '106')
        actual = described_class.call(input)

        expect(actual.size).to eq(4)
        expect(actual).to eq([[
          "\n",
          "_id                           2",
          "url                           http://initech.zendesk.com/api/v2/users/2.json",
          "external_id                   c9995ea4-ff72-46e0-ab77-dfe0ae1ef6c2",
          "name                          Cross Barlow",
          "alias                         Miss Joni",
          "created_at                    2016-06-23T10:31:39 -10:00",
          "active                        true",
          "verified                      true",
          "shared                        false",
          "locale                        zh-CN",
          "timezone                      Armenia",
          "last_login_at                 2012-04-12T04:03:28 -10:00",
          "email                         jonibarlow@flotonic.com",
          "phone                         9575-552-585",
          "signature                     Don't Worry Be Happy!",
          "organization_id               106",
          "tags                          Foxworth; Henrietta; Herlong; Woodlands",
          "suspended                     false",
          "role                          admin",
          "organization_name             Qualitern",
          "assigned_ticket_subjects      A Catastrophe in Bermuda; A Problem in Svalbard and Jan Mayen Islands"],
        ["\n",
          "_id                           41",
          "url                           http://initech.zendesk.com/api/v2/users/41.json",
          "external_id                   497def74-ce88-442e-814c-2fb8ce945dd9",
          "name                          Alvarez Black",
          "alias                         Miss Janet",
          "created_at                    2016-01-12T10:26:24 -11:00",
          "active                        false",
          "verified                      false",
          "shared                        true",
          "locale                        en-AU",
          "timezone                      Finland",
          "last_login_at                 2015-02-21T08:07:14 -11:00",
          "email                         janetblack@flotonic.com",
          "phone                         9464-452-234",
          "signature                     Don't Worry Be Happy!",
          "organization_id               106",
          "tags                          Bend; Celeryville; Fedora; Troy",
          "suspended                     false",
          "role                          end-user",
          "organization_name             Qualitern",
          "assigned_ticket_subjects      A Catastrophe in Bahamas; A Drama in India; A Nuisance in Luxembourg"],
        ["\n",
          "_id                           42",
          "url                           http://initech.zendesk.com/api/v2/users/42.json",
          "external_id                   dc516f83-e4cf-4e43-b1ef-87450db34cdf",
          "name                          Sampson Castillo",
          "alias                         Mr Aimee",
          "created_at                    2016-03-20T02:44:50 -11:00",
          "active                        true",
          "verified                      false",
          "shared                        true",
          "locale                        de-CH",
          "timezone                      Thailand",
          "last_login_at                 2015-05-23T11:04:31 -10:00",
          "email                         aimeecastillo@flotonic.com",
          "phone                         8844-343-366",
          "signature                     Don't Worry Be Happy!",
          "organization_id               106",
          "tags                          Bethpage; Johnsonburg; Santel; Stagecoach",
          "suspended                     false",
          "role                          agent",
          "organization_name             Qualitern",
          "assigned_ticket_subjects      A Problem in Japan"],
        ["\n",
          "_id                           63",
          "url                           http://initech.zendesk.com/api/v2/users/63.json",
          "external_id                   a850f4a0-61f4-41bb-b673-e73d179357e4",
          "name                          Lynnette Dunlap",
          "alias                         Mr Jacobs",
          "created_at                    2016-01-05T09:15:41 -11:00",
          "active                        false",
          "verified                      false",
          "shared                        true",
          "locale                        zh-CN",
          "timezone                      Turkey",
          "last_login_at                 2013-10-20T12:07:13 -11:00",
          "email                         jacobsdunlap@flotonic.com",
          "phone                         9154-802-696",
          "signature                     Don't Worry Be Happy!",
          "organization_id               106",
          "tags                          Caroleen; Clarksburg; Graniteville; Manila",
          "suspended                     true",
          "role                          admin",
          "organization_name             Qualitern",
          "assigned_ticket_subjects      A Nuisance in Poland; A Problem in Ukraine"]]
        )
      end
    end
  end

  # TODO: rcov
end
