class AppConstants {
  static const String baseUrl = 'https://api.react-finland.fi/graphql';

  static const String queryAllConferences = '''
      {
        allConferences {
          id
          name
          startDate
          slogan
        }
      }
    ''';

  static const String queryAllSponsors = '''
      {
  sponsors {
    type
    image {
      url
    }
  }
}
    ''';

  static const String conferenceByIdQuery = '''
      query GetConferenceById(\$id: ID!) {
        conference(id: \$id) {
    id
    name
    startDate

    organizer {
      name
      image{
        url
      }
      about
    }
    speakers {
      name
      image{
        url
      }
      about
    }
    schedules {
      day
      description
      intervals {
        sessions{
          title
          begin
          end
        }
      } 
    }
    sponsors{
      name
      image{
        url
      }
      about
    }
  }
}''';
}
