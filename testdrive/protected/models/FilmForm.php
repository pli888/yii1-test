<?php
/**
 * Created by PhpStorm.
 * User: peterli
 * Date: 20/6/2019
 * Time: 4:25 PM
 */

/**
 * FilmForm class.
 * FilmForm is the data structure for keeping information about a film,
 * currently only its title and director. It is used by the 'addFilm' action of
 * 'SiteController'.
 */
class FilmForm extends CFormModel
{
    // Two attributes declared to keep the user-entered film title and its
    // director
    public $title;
    public $director;

    // Returns an array of rules. There is currently 2 rules.
    public function rules()
    {
        return array(
            array('title, director', 'required'),
            array('director', 'acceptedDirectors'),
        );
    }

    // We will only accept 2 directors to test creation of custom validator
    public function acceptedDirectors($attribute, $params)
    {
        // Create indexed array of film directors
        $directors = array( "Christopher Nolan", "Stanley Kubrick" );
    }
}