
function changeBox()
{
    var checkbox = document.forms[ 0 ].elements[ 'foreigner' ];
    var italy = document.getElementById( "tab-italy" );
    var foreigner = document.getElementById( "tab-foreigner" );
    foreigner.style.display = "none";
    italy.style.display = "none";
    if ( checkbox[0].checked )
    {
        italy.style.display = "";
    }
    if ( checkbox[1].checked )
    {
        foreigner.style.display = "";
    }
}

function setAutocompleteOff()
{
    var d = document.forms[0];
    if ( d && d.elements['illnessSelected'] )
    {
        d.elements['illnessSelected'].setAttribute( "autocomplete","off" );
    }
}

Date.dayNames = ['domenica', 'lunedì', 'martedì', 'mercoledì', 'giovedì', 'venerdì', 'sabato'];
Date.abbrDayNames = ['dom', 'lun', 'mar', 'mer', 'gio', 'ven', 'sab'];
Date.monthNames = ['gennaio', 'febbraio', 'marzo', 'aprile', 'maggio', 'giugno', 'luglio', 'agosto', 'settembre', 'ottobre', 'novembre', 'dicembre'];
Date.abbrMonthNames = ['gen', 'feb', 'mar', 'apr', 'mag', 'giu', 'lug', 'ago', 'set', 'ott', 'nov', 'dic'];
Date.format = 'dd/mm/yyyy';

function verifyOccupation( form )
{
    var enabled = false;
    var d = form.elements['birthDate'].value;

    if ( d != "" )
    {
        var date1 = Date.fromString(d, Date.format);
        var date2 = new Date();
        date2.setYear( date2.getYear() -25 );
        if ( date1 < date2 )
        {
            enabled = true;
        }

    }


    form.elements['motherEducation'].disabled = enabled;
    form.elements['fatherEducation'].disabled = enabled;
    form.elements['motherOccupation'].disabled = enabled;
    form.elements['fatherOccupation'].disabled = enabled;
}


TaxCode = function(  )
{
    this.error =  "Codice Fiscale non valido";
    this.ok =  "Codice Fiscale valido";
    this.png_error =  "img/remove.png";
    this.png_ok =  "img/ok.png";
    this.consonants =  "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ";
    this.number = "0123456789";
    this.arrayMonth = Array( "", "A", "B", "C", "D", "E", "H", "L",  "M", "P", "R", "S", "T" );

    this.calcTaxCodeComplete = function( form )
    {
        this.form = form;
        this.surname = this.form.elements['surname'].value;
        this.name = this.form.elements['name'].value;
        this.birthDate = this.form.elements['birthDate'].value;
        this.sex = this.form.elements['sex'][1].checked;
        this.cadastre = this.form.elements['cadastre'].value;
        this.taxCode = this.form.elements['taxCode'].value.toUpperCase();
        var cf = "";
        var message = "";
        if ( this.surname != "" && this.name != "" && this.birthDate != "" && this.cadastre != "")
        {
          rc = this.calcTaxCodeSurname();
          rn = this.calcTaxCodeName();
          rN = this.calcBirth();

          cf = rc + rn + rN + this.cadastre;
          cf += this.calcolateK( cf );
          var id;
          if ( cf != this.taxCode ) 
          {
            id = document.getElementById( "cf_valid" );
            id.style.display = 'none';
            id = document.getElementById( "cf_not_valid" );
            id.style.display = '';             
          }
          else 
          {
            id = document.getElementById( "cf_valid" );
            id.style.display = '';
            id = document.getElementById( "cf_not_valid" );
            id.style.display = 'none';
            this.form.elements['taxCode'].value = this.taxCode;
          }
        }
    }

    this.calcBirth = function()
    {
        var day = parseInt( this.birthDate.substring( 0, 2 ) );
        if ( this.sex )
        {
            day += 40;
        }
        if ( day < 10 ) day= "0" + day;

        var month = parseInt( this.birthDate.substring( 3, 5 ) );
        month = this.arrayMonth[ month ];

        var year = this.birthDate.substring( 8, 10 );


        return year + month + day;
    }

    this.calcTaxCodeSurname = function()
    {
        var code = "";
        code = this.getConsonants( this.surname );
        if (code.length >= 3)
        {
            code = code.substring(0, 3);
        }
        else
        {
            code += this.getVocal( this.surname ).substring( 0, 3 - code.length )
            if ( code.length < 3 )
            {
                for ( i = code.length; i < 3; i++ )
                {
                    code += "X";
                }
            }
        }
        return code;
    }

    this.calcTaxCodeName = function()
    {
        var code = "";
        cons = this.getConsonants( this.name );
        if ( cons.length > 3 )
        {
            code = cons.substring( 0, 1 ) + cons.substring( 2, 3 ) + cons.substring( 3, 4 );
        }
        else
        {
            if ( cons.length == 3 )
            {
                code = cons;
            }
            else
            {
                code = cons + this.getVocal( this.name ).substring( 0, 3 - cons.length );
                if ( code.length < 3 )
                {
                    for ( i = code.length; i < 3; i++ )
                    {
                        code += "X";
                    }
                }
            }
        }
        return code;
    }

    this.getConsonants = function( str )
    {
       var cns = "";
       for ( i = 0; i < str.length; i++ )
       {
          if ( this.consonants.indexOf( str.substring( i, i + 1 ) ) != -1 )
          {
             cns += str.substring( i, i + 1 );
          }
       }
       return cns.toUpperCase();
    }

    this.getVocal = function( str )
    {
       var voc = "";
       for ( i = 0; i < str.length; i++ )
       {
          if ( this.consonants.indexOf( str.substring( i, i + 1 ) ) == -1 && str.substring( i, i + 1 ) != " " )
          {
             voc += str.substring( i, i + 1 );
          }
       }
       return voc.toUpperCase();
    }

    this.calcolateK =function( str )
    {
       var somma = 0, k;
       var arrPari = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
       var arrDispari = new Array(
          Array(0,1),
          Array(1,0),
          Array(2,5),
          Array(3,7),
          Array(4,9),
          Array(5,13),
          Array(6,15),
          Array(7,17),
          Array(8,19),
          Array(9,21),
          Array("A",1),
          Array("B",0),
          Array("C",5),
          Array("D",7),
          Array("E",9),
          Array("F",13),
          Array("G",15),
          Array("H",17),
          Array("I",19),
          Array("J",21),
          Array("K",2),
          Array("L",4),
          Array("M",18),
          Array("N",20),
          Array("O",11),
          Array("P",3),
          Array("Q",6),
          Array("R",8),
          Array("S",12),
          Array("T",14),
          Array("U",16),
          Array("V",10),
          Array("W",22),
          Array("X",25),
          Array("Y",24),
          Array("Z",23)
       );
       for (i = 0; i < str.length; i += 2)
       {
          for (j = 0; j < arrDispari.length; j++)
          {
             if (str.substring(i, i + 1).toUpperCase() == arrDispari[j][0])
             {
                somma += parseInt(arrDispari[j][1],10);
                break;
             }
          }
       }
       for (i = 1; i < str.length; i += 2)
       {
          if (isNaN(str.substring(i, i + 1)))
             somma += parseInt(arrPari.indexOf(str.substring(i, i + 1)),10);
          else
             somma += parseInt(str.substring(i, i + 1),10);
       }
       k = somma % 26;
       k = arrPari.charAt(k);
       return k;
    }

}

var jTaxCode = new TaxCode();
