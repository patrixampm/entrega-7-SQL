-- Listar las pistas (tabla Track) con precio mayor o igual a 1€
SELECT P.Name,
		P.UnitPrice
FROM Track P
WHERE P.UnitPrice >= 1

-- Listar las pistas de más de 4 minutos de duración
SELECT	T.Name,
		T.Milliseconds
FROM Track T
WHERE T.Milliseconds > 240000

-- Listar las pistas que tengan entre 2 y 3 minutos de duración
SELECT	T.Name,
		T.Milliseconds
FROM Track T
WHERE T.Milliseconds BETWEEN 120000 AND 180000

-- Listar las pistas que uno de sus compositores (columna Composer) sea Mercury
SELECT	T.Name,
		T.Composer
FROM Track T
WHERE T.Composer LIKE '%Mercury%'

-- Calcular la media de duración de las pistas (Track) de la plataforma
SELECT	AVG(T.Milliseconds) AS AvarageDuration
FROM Track T

-- Listar los clientes (tabla Customer) de USA, Canada y Brazil
SELECT	C.FirstName,
		C.LastName,
		C.Country
FROM Customer C
WHERE C.Country IN ('USA', 'Canada', 'Brazil')

-- Listar todas las pistas del artista 'Queen' (Artist.Name = 'Queen')
SELECT	R.Name,
		A.Title,
		T.Name
FROM Album A
INNER JOIN Artist R
ON R.ArtistID = A.ArtistId
INNER JOIN Track T
ON T.AlbumId = A.AlbumId
WHERE R.Name = 'Queen'

-- Listar las pistas del artista 'Queen' en las que haya participado como compositor David Bowie
SELECT	R.Name,
		A.Title,
		T.Name
FROM Album A
INNER JOIN Artist R
ON R.ArtistID = A.ArtistId
INNER JOIN Track T
ON T.AlbumId = A.AlbumId
WHERE R.Name = 'Queen' AND T.Composer LIKE '%Bowie%'

-- Listar las pistas de la playlist 'Heavy Metal Classic'
SELECT	L.Name,
		T.Name
FROM PlaylistTrack P
INNER JOIN Track T
ON T.TrackId = P.TrackId
INNER JOIN Playlist L
ON L.PlaylistId = P.PlaylistId
WHERE L.Name = 'Heavy Metal Classic'

-- Listar las playlist junto con el número de pistas que contienen
SELECT	L.Name,
		Count(P.TrackId) AS NumberOfTracks
FROM Playlist L
INNER JOIN PlaylistTrack P
ON L.PlaylistId = P.PlaylistId
GROUP BY L.Name

-- Listar las playlist (sin repetir ninguna) que tienen alguna canción de AC/DC
SELECT	DISTINCT(P.Name)
FROM Playlist P
INNER JOIN PlaylistTrack PT
ON PT.PlaylistId = P.PlaylistId
INNER JOIN Track T
ON T.TrackId = PT.TrackId
INNER JOIN Album A
ON A.AlbumId = T.AlbumId
INNER JOIN Artist AR
ON AR.ArtistId = A.ArtistId
WHERE AR.Name = 'AC/DC'

-- Listar las playlist que tienen alguna canción del artista Queen, junto con la cantidad que tienen
SELECT	DISTINCT(P.Name),
		COUNT(PT.TrackId) AS NumberOfTracks
FROM Playlist P
INNER JOIN PlaylistTrack PT
ON PT.PlaylistId = P.PlaylistId
INNER JOIN Track T
ON T.TrackId = PT.TrackId
INNER JOIN Album A
ON A.AlbumId = T.AlbumId
INNER JOIN Artist AR
ON AR.ArtistId = A.ArtistId
WHERE AR.Name = 'Queen'
GROUP BY P.Name

-- Listar las pistas que no están en ninguna playlist
SELECT	T.TrackId,
		T.Name
FROM Track T
LEFT JOIN PlaylistTrack PT
ON PT.TrackId = T.TrackId
WHERE PT.PlaylistId IS NULL

-- Listar los artistas que no tienen album
SELECT	AR.ArtistId,
		AR.Name
FROM Artist AR
LEFT JOIN Album AL
ON AL.ArtistId = AR.ArtistId
WHERE AL.AlbumId IS NULL

-- Listar los artistas con el número de albums que tienen
SELECT	DISTINCT(AR.ArtistId),
		COUNT(AL.AlbumId) AS NumberOfAlbums,
		AR.Name
FROM Artist AR
LEFT JOIN Album AL
ON AR.ArtistId = AL.ArtistId
GROUP BY AR.ArtistId, AR.Name
