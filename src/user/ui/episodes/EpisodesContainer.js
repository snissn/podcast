import { connect } from 'react-redux'
import Episodes from './Episodes'
import { updateUser } from './EpisodesActions'

const mapStateToProps = (state, ownProps) => {
  console.log('hi');
  console.log(state);
  return {
    name: state.user.data.name,
    description: state.user.data.description
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    onProfileSubmit: (name) => {
      event.preventDefault();

      dispatch(updateUser(name))
    }
  }
}

const EpisodesContainer  = connect(
  mapStateToProps,
  mapDispatchToProps
)(Episodes)

export default EpisodesContainer
